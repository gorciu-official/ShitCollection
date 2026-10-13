#!/bin/sh
# HELLO!!!!!!!!
# This is a Discord bot written in x86_64 assembly, enjoy!
# This is a polyglot file that automates building, start it with
# sh to automatically compile shit. some shit was vibecoded wow

set -e; tail -n +8 "$0" > src/bot-excluded.asm; nasm -f elf64 src/bot-excluded.asm -o src/bot-asm.o; gcc -no-pie src/bot-asm.o -o bot-asm.elf -lcurl; exec ./bot-asm.elf; exit 0

; ---

default rel

bits 64

global main

extern curl_global_init, curl_global_cleanup
extern curl_easy_init, curl_easy_setopt, curl_easy_perform, curl_easy_cleanup
extern curl_slist_append, curl_slist_free_all
extern sleep, rand, srand, time
extern fopen, fgets, fclose, snprintf, strlen, strstr, strcmp, strcpy, memcpy

CURL_GLOBAL_DEFAULT   equ 3
CURLOPT_URL           equ 10002
CURLOPT_POSTFIELDS    equ 10015
CURLOPT_HTTPHEADER    equ 10023
CURLOPT_WRITEFUNCTION equ 20011
CURLOPT_HTTPGET       equ 80

; setopt with a static-label pointer argument
%macro SETOPT_PTR 2
    mov  rdi, [g_curl]
    mov  esi, %1
    lea  rdx, [%2]
    xor  eax, eax
    call curl_easy_setopt
%endmacro

section .data
url_msgs:    db "https://discord.com/api/v10/channels/1403639419025752188/messages?limit=1", 0
url_post:    db "https://discord.com/api/v10/channels/1403639419025752188/messages", 0
url_me:      db "https://discord.com/api/v10/users/@me", 0
token_path:  db "token.txt", 0
fopen_mode:  db "r", 0
auth_fmt:    db "Authorization: Bot %s", 0
h_type:      db "Content-Type: application/json", 0
h_agent:     db "User-Agent: DiscordBot (https://example.com, 1.0)", 0
key_id:      db `"id":"`, 0
key_author:  db `"author":{"id":"`, 0
body1:       db '{"content":"jebać bursztynOS"}', 0
body2:       db '{"content":"assembly jest dopierdolone, dojebane i dowalone"}', 0

section .bss
g_curl:        resq 1
g_headers:     resq 1
token_buf:     resb 128
auth_header:   resb 160
resp_buf:      resb 16384
resp_len:      resq 1
msg_id_buf:    resb 64
author_id_buf: resb 64
last_id:       resb 64
own_id:        resb 64
first_run:     resb 1

section .text

; size_t write_cb(char *ptr, size_t size, size_t nmemb, void *userdata)
; appends received data into resp_buf / resp_len (globals)
write_cb:
    push rbx
    push r12
    push r13
    mov  r12, rdi            ; data ptr
    mov  rax, rsi
    imul rax, rdx            ; total bytes = size*nmemb
    mov  r13, rax
    mov  rbx, [resp_len]
    cmp  rbx, 16000           ; leave room, toy bot, no need to be fancy
    jae  .skip
    lea  rdi, [resp_buf + rbx]
    mov  rsi, r12
    mov  rdx, r13
    call memcpy
    add  rbx, r13
    mov  [resp_len], rbx
    mov  byte [resp_buf + rbx], 0
.skip:
    mov  rax, r13
    pop  r13
    pop  r12
    pop  rbx
    ret

; char *copy_until_quote(char *src /*rdi*/, char *dst /*rsi*/)
; copies bytes until '"' or NUL, NUL-terminates dst. Leaf function.
copy_until_quote:
.loop:
    mov  al, [rdi]
    cmp  al, 0
    je   .end
    cmp  al, '"'
    je   .end
    mov  [rsi], al
    inc  rdi
    inc  rsi
    jmp  .loop
.end:
    mov  byte [rsi], 0
    ret

; char *extract_field(char *haystack /*rdi*/, char *key /*rsi*/)
; returns pointer just past the first occurrence of key in haystack, or NULL
extract_field:
    push rbp
    mov  rbp, rsp
    and  rsp, -16
    sub  rsp, 16
    mov  [rsp], rdi
    mov  [rsp+8], rsi
    call strstr
    test rax, rax
    je   .nf
    mov  [rsp], rax
    mov  rdi, [rsp+8]
    call strlen
    mov  rdi, [rsp]
    add  rdi, rax
    mov  rax, rdi
    jmp  .done
.nf:
    xor  rax, rax
.done:
    mov  rsp, rbp
    pop  rbp
    ret

; char *read_token(void) -> pointer to token_buf, or NULL
read_token:
    push rbp
    mov  rbp, rsp
    and  rsp, -16
    sub  rsp, 16
    lea  rdi, [token_path]
    lea  rsi, [fopen_mode]
    call fopen
    test rax, rax
    je   .fail
    mov  [rsp], rax
    lea  rdi, [token_buf]
    mov  esi, 128
    mov  rdx, [rsp]
    call fgets
    mov  rdi, [rsp]
    call fclose
    lea  rdi, [token_buf]
    call strlen
    test rax, rax
    je   .done
    lea  rdi, [token_buf]
    add  rdi, rax
    dec  rdi
    cmp  byte [rdi], 10
    jne  .done
    mov  byte [rdi], 0
.done:
    lea  rax, [token_buf]
    jmp  .ret
.fail:
    xor  rax, rax
.ret:
    mov  rsp, rbp
    pop  rbp
    ret

build_auth_header:
    push rbp
    mov  rbp, rsp
    and  rsp, -16
    sub  rsp, 16
    lea  rdi, [auth_header]
    mov  esi, 160
    lea  rdx, [auth_fmt]
    lea  rcx, [token_buf]
    xor  eax, eax
    call snprintf
    mov  rsp, rbp
    pop  rbp
    ret

init_curl:
    push rbp
    mov  rbp, rsp
    and  rsp, -16
    sub  rsp, 16
    mov  edi, CURL_GLOBAL_DEFAULT
    call curl_global_init

    xor  edi, edi
    lea  rsi, [auth_header]
    call curl_slist_append
    mov  rdi, rax
    lea  rsi, [h_type]
    call curl_slist_append
    mov  rdi, rax
    lea  rsi, [h_agent]
    call curl_slist_append
    mov  [g_headers], rax

    call curl_easy_init
    mov  [g_curl], rax

    mov  rdi, [g_curl]
    mov  esi, CURLOPT_HTTPHEADER
    mov  rdx, [g_headers]
    xor  eax, eax
    call curl_easy_setopt

    SETOPT_PTR CURLOPT_WRITEFUNCTION, write_cb

    mov  rsp, rbp
    pop  rbp
    ret

; void http_get(char *url /*rdi*/)
http_get:
    push rbp
    mov  rbp, rsp
    and  rsp, -16
    sub  rsp, 16
    mov  [rsp], rdi
    mov  qword [resp_len], 0

    mov  rdi, [g_curl]
    mov  esi, CURLOPT_URL
    mov  rdx, [rsp]
    xor  eax, eax
    call curl_easy_setopt

    mov  rdi, [g_curl]
    mov  esi, CURLOPT_HTTPGET
    mov  rdx, 1
    xor  eax, eax
    call curl_easy_setopt

    mov  rdi, [g_curl]
    call curl_easy_perform

    mov  rsp, rbp
    pop  rbp
    ret

; void http_post(char *url /*rdi*/, char *body /*rsi*/)
http_post:
    push rbp
    mov  rbp, rsp
    and  rsp, -16
    sub  rsp, 16
    mov  [rsp], rdi
    mov  [rsp+8], rsi
    mov  qword [resp_len], 0

    mov  rdi, [g_curl]
    mov  esi, CURLOPT_URL
    mov  rdx, [rsp]
    xor  eax, eax
    call curl_easy_setopt

    mov  rdi, [g_curl]
    mov  esi, CURLOPT_POSTFIELDS
    mov  rdx, [rsp+8]
    xor  eax, eax
    call curl_easy_setopt

    mov  rdi, [g_curl]
    call curl_easy_perform

    mov  rsp, rbp
    pop  rbp
    ret

main:
    push rbp
    mov  rbp, rsp
    and  rsp, -16
    sub  rsp, 16

    call read_token
    test rax, rax
    jne  .have_token
    ; no token.txt -> bail out quietly
    mov  rsp, rbp
    pop  rbp
    mov  eax, 1
    ret
.have_token:
    call build_auth_header
    call init_curl

    ; fetch our own user id, so we don't reply to ourselves
    lea  rdi, [url_me]
    call http_get
    lea  rdi, [resp_buf]
    lea  rsi, [key_id]
    call extract_field
    test rax, rax
    je   .no_own_id
    mov  rdi, rax
    lea  rsi, [own_id]
    call copy_until_quote
.no_own_id:

    mov  byte [last_id], 0
    mov  byte [first_run], 1

    xor  edi, edi
    call time
    mov  edi, eax
    call srand

.loop:
    lea  rdi, [url_msgs]
    call http_get

    lea  rdi, [resp_buf]
    lea  rsi, [key_id]
    call extract_field
    test rax, rax
    je   .do_sleep

    mov  rdi, rax
    lea  rsi, [msg_id_buf]
    call copy_until_quote

    lea  rdi, [msg_id_buf]
    lea  rsi, [last_id]
    call strcmp
    test eax, eax
    je   .do_sleep              ; same message as last time we saw, nothing new

    ; new message id -> remember it
    lea  rdi, [last_id]
    lea  rsi, [msg_id_buf]
    call strcpy

    ; who sent it?
    lea  rdi, [resp_buf]
    lea  rsi, [key_author]
    call extract_field
    test rax, rax
    je   .author_done
    mov  rdi, rax
    lea  rsi, [author_id_buf]
    call copy_until_quote
    jmp  .author_checked
.author_done:
    mov  byte [author_id_buf], 0
.author_checked:

    cmp  byte [first_run], 1
    jne  .not_first
    mov  byte [first_run], 0
    jmp  .do_sleep               ; don't react to whatever was already there on startup
.not_first:

    lea  rdi, [author_id_buf]
    lea  rsi, [own_id]
    call strcmp
    test eax, eax
    je   .do_sleep                ; it's our own message, ignore it

    ; pick a reaction and send it
    call rand
    test eax, 1
    jz   .use_body1
    lea  rsi, [body2]
    jmp  .send
.use_body1:
    lea  rsi, [body1]
.send:
    lea  rdi, [url_post]
    call http_post

.do_sleep:
    jmp  .loop
