# THIS SHIT CONTAINS SPOILERS
# THIS SHIT ALSO IS NOT A COMPREHENSIVE GUIDE ON HOW TO FINISH THE GAME, IT IS JUST ORGANIZED SHIT THAT I'VE DECIDED TO PUT




# stage 1

final image is `thingy-final.png`

thingy.jpg is edited to thingy-exif.png with EXIF kind of shit:

a)

copyright is set to `AHAAYQBzAHMAcABoAHIAYQBzAGUAIABwAGEAcgB0ACAAMQA6ACAAIgBwAGEAcwBzAHAAaAByAGEAcwBlAC0AIg==` which after base64-decode 
using utf16BE is:

`passphrase part 1: "passphrase-"`

b)

software is set to openstego which is a software used to hide `thingy-message.txt` in

decrypt w/ `openstego extract --stegofile=thingy-final.png -xd data`

this message file contains a PGP-encrypted message w/ password `passphrase-bingo`:

```
let's meet our peak hosting provider, which will take you on a peak tour to complete
the puzzles.

rishile-more-puzzl3s.netlify.app
```

---

the second part of the passphrase can be obtained by opening the png file in a text editor and scrolling to the down.









# stage 2

`AN HTML PAGE. 3 LETTER NAME OF 1920X1080 ALONG WITH A 3-DIGIT CODE: 747.` is encoded to morse code: 

`.- -. / .... - -- .-.. / .--. .- --. . .-.-.- / ...-- / .-.. . - - . .-. / -. .- -- . / --- ..-. / .---- ----. ..--- ----- -..- .---- ----- ---.. ----- / .- .-.. --- -. --. / .-- .. - .... / .- / ...-- -....- -.. .. --. .. - / -.-. --- -.. . ---... / --... ....- --... .-.-.-`

that is at `website/thingy.mp3` which the user will see after visiting the site from stage 1.

that means that for stage 3 you need to go to `fhd_747.html`


















# stage 3 

after de-xoring shit u get a `stage3-msg.txt` which after deAESing with ecb gives u 

```
/getmorefromus.html
```



















# stage 4

decrypted yt channel messages:

```
part 1:

/XXX/[...]/[...]
```

```
part 2:

/[...]/folder/[...]
```

```
part 3:

/[...]/[...]/hi.html
```

stage 5 at `/787/folder/hi.html`













# stage 5

invert colors

stretch barcode

scan barcode

get this 

```
/answers/wawf.html
```











# stage 6 

get colors from the image: `033a38` and `a90f0f`

concatenate: `033a38a90f0f`

get pgp from exif comment

pgp:

```
-----BEGIN PGP MESSAGE-----

jA0ECQMKQ7addYQ1x9b/0osBHoOnDMNpAqLb8TdvqEJ9iKjJhqUtnI5kh3FtzMRW
GVr6FOHtQ1AQYo3up8vpxcGqJoYvt42QSopJugDPrDeSgrLytq/dM2gyS3rhrQJ5
GkmuB0cxHSGFo3E8B5bdaUP1nN+mdsKb4XNlEvzzQQp4CgCoonnGy+rbscENPRRI
g9Da/zMTXZZjXtLt
=qnqJ
-----END PGP MESSAGE-----
```

pgp -> book cipher:

```
7-6-13
dash
5-15-11
dash 
6-34-6
.html

get the original transformer on paper
```

that refers to `Attention is all you need` by Google

book cipher -> plaintext:

```
future-of-complexity.html
```











# stage 7

yes you need a table of contents to navigate this shit believe me

i love overusing amazing and awesome in this level

***table of contents:***
- [part 1: thread ids](#thread-ids)
- [part 2: rsa](#rsa)
- [part 3: sounds are awesome](#sounds-are-awesome)
- [part 4: images are awesome too](#images-are-awesome-too)
- [clue to next level: runes](#runes)
- [part 5: numbers are amazing](#numbers-are-amazing)
- [part 6: random letters](#random-letters)

if u want a quick solution: 

`linker-218179984667523-uszokot-netherlands-lkrt-powsr.html`

## thread IDs

thread ids make the first part of url:

```
78697A7C283928 (y)
776E287D7A7442 (y)
28747176736D7A (y)
28307277717628 (y)
6C716E6E6D7A6D (y)
767C2878697A7C (y)
7B282302717C70 (y)
286C697B706D7B (y)
2869766C287D7B (y)
6D28707C757428 (y)
6D263A7C6D767B (y)
71777631000000 (y)
```

hexdump -> text

```
xiz|(9(wn(}ztB(tqvsmz(0rwqv(lqnnmzmv|(xiz|{(⌂q|p(li{pm{(ivl(}{m(p|ut(m☺|mv{qwv1
```

text -> readable text (using ceasar cipher w/ whole ASCII table):

```
part 1 of url: linker (join different parts with dashes and use html extension)
```


## RSA

```
Public RSA parameters:

n = 1000000016000000063
e = 65537

Encrypted message:

-----BEGIN COMPRESSED RSA ENCRYPTED MESSAGE-----
Version: 1.99
Scheme: Crypt::RSA::ES::OAEP

DRlSdF5BBSI=
-----END COMPRESSED RSA ENCRYPTED MESSAGE-----

AES-GCM IV:

Ljjc/hrd+gOVLIaN

AES-GCM ciphertext:

hXb0GR0tuvdyksqN2l4YwR/8WBFG84hyl1LP3op9skIHfCcJt/H/Tpr4r+weOOPFdsJ1xS9W8lKwcox+377yr/JhgjQ=
```

solution

```
========== SOLUTION ==========
RSA CHALLENGE SOLUTION

p = 1000000007
q = 1000000009

n = 1000000016000000063

phi = 1000000014000000048

e = 65537

d = 648946405777194593

RSA secret (Base64) = xm78e7OD

RSA secret (integer) = 218179984667523

AES-256 key (SHA-256(secret), Base64) = C8dfBHtacSHKneEpykKt4j6duPP68uv9Y434OJUlGsI=

IV (Base64) = Ljjc/hrd+gOVLIaN

AES-GCM ciphertext (Base64) = hXb0GR0tuvdyksqN2l4YwR/8WBFG84hyl1LP3op9skIHfCcJt/H/Tpr4r+weOOPFdsJ1xS9W8lKwcox+377yr/JhgjQ=

FLAG = the secret key is the thing to get for part 2 of url
```

## Sounds are awesome 

Open the garbage sound in a spectogram to reveal a message: 

```
part 3: 

<garbage painting>

uszokot
```

## Images are awesome too 

Using openstego known from part 1 we get an ISO file which upon booting displays: 

```
zepd 4 mq vsuovakwcn rywi mp wmwi ayyldvw sr cevmzi
```

after vigener cipher decrypt:

```
part 4 is lowercased name of some country in europe
```

after bruteforcing, u get 

```
netherlands
```

## Runes

Runes are presented in this level, but are not necesairly required in this level to complete it.

the `port in poland` refers to `porta cipher`, while `keys not key` refers to the key for it.

after deciphering and making it readable, u get this:

```
for meaning of runes visit runes/meaning.md. this thread does not have any part of uri to level 8
```

## Numbers are amazing 

decode shit using this:

```
function decode(numbers: number[]): string {
    let previous = 1000;

    return numbers
        .map(n => {
            const value = n - previous;
            previous = n;
            return String.fromCharCode(value);
        })
        .join("");
}
```

u get:

```
part 5: lkrt
```

that's kinda trolling bc lkrt is not a cipher but a literal answer

## random letters 

```
pKeWabrWrtRntUhk LM16pIi iDOicfHsiWm NE7pE4uo2GCwnsvswhMr
15x + 5 = 12x + 17
```

looks random but is not.

decodes to 

```
part 6 is powsr
```

if you only get fourth characters or smth
























# end message 

pgp (password `fourtySecondsToLive`):

```
-----BEGIN PGP MESSAGE-----

jA0ECQMKEdUcp6HujT7/0ukBakv32YUAVhlTgkE6flR7o/062NySE8zNBmdB1IWu
DUoavEvaxCdDuBYvd8G9Y6u1V+rVfi14sjRx86284I66YTsQD3Pv/RuJYBDzRoLg
Q/fG0iXXeIISW+EY0uhuNIfutr9b3oePlnEI9HQkLnugp79ZLMEFXnVxl9G4OyRZ
2Oh4fYg8XRHUb89ioddrSckQ/6CWzOA2X2V3dUsT58cRnJ2s9T+j/MagWo5DMFqe
CWkSIy8DqvizPwBzVu0NdSqPynqjsAECsvLzResyACLpFWL80ohfFMWb5WyGOy50
jd/QQ14EldkY6Uf6xyvcJOktBD2yIazgl29mpJTtg/SWPfinCTgyPQZg7inSFhhD
gGjbwF4o61Y/YI/hdVy4NRLE6B7Mdf7fsAitSRx6ws0Fcb/wAgTgCWfmmgv3aoFz
YiIzlS0+GuXaJutbV+o9COzYVUEsxdVmypxki5JWHWzAcROE/fkOUitfJG+n334O
Xxqa5/2ExiGu2W5hvg3GcFqFXQIKvzrIexO5dR9Jx5L/l75loLMUD8pBWUBC4Pz4
Vk8hXAtJLvvEE2yswMnEtcfqIwl5LR0RIB/bEVXVAKmxdia3MsVRQR3CC9OjjQRP
nO2tqJXMyXWakrS9r8XoCVSUP1+guYZcOEMfVnS1TSVarvcdAzqpP3OGsb88Iqa4
RMAQpBHNJXcG7f8fwf8MeRbUMT7rhobaYKodknaUscs0ejAeroRfmyireULwPNGA
RyJYrkgPLXznHeZO4wVi5L7RyW0V2rrYQq5zrszGCFszlleAsToQRrazfCfdoJ0e
zCsk06AAG1eNVoIlOHMlxkuyJLMaMEwQWoG/mFOyhe+nvPfdGkQsz0Bx/qLpaXPD
iawIbl9CVJs3VMsLCbRf7w9QBfKhWALlctUZiRBJgeBinz6wxKAVEndc02UDuEvQ
POzOuoYoM131b5/yGAXAt7NAcw==
=VuWG
-----END PGP MESSAGE-----
```

decrypted:

```
We will contact the president of the USA to start collaboration with this civilization.

Here is a message from the original human poster. Note that we didn't review it:

---
yay! u have succesfully finished my "arg"!

the storytelling was quite meh, but it was because
i wanted to allow myself for as much flexibility as
possible. if you have any ideas it could be improved,
i am always looking forward to make another riddle
game like this one! also that was my first ever arg,
so... 

you may contact the creator with the following end
token to have it confirmed that u have finished this 
puzzle:
    r0o4Op-d6Zp

if you want to play other games that i've tried making 
so far and are quite similar, try:
 - my first riddle game:
     https://resonant-baklava-89bc78.netlify.app
 - previous iteration of rishile i was doing before
   deleting it and making this one:
     unfortuneally i don't have a web server, but u can 
     contact me on discord: @gorciu_official and we'll 
     work something out. that is because the web server 
     has some quirks that make some riddles work, that's 
     why I can't host it on netlify
---
```
