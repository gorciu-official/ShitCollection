#!/usr/bin/bash

# -- security
umask 077

# -- pre-run checks
[[ $- != *i* ]] && return

# -- base bash aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fastfetch='fastfetch --kitty-icat ~/linuxlogo.png --logo-width 40 --color \#ff9f00'

# -- funny aliases
alias pajtonik='python'

# -- convienience aliases
alias neocitiespush='neocities logout -y && neocities push .'
alias paru='yay'

# -- configuration
alias edit_hypr_cfg='nvim ~/.config/hypr/hyprland.conf'
alias edit_cfg='nvim ~/.config'
alias edit_bash_cfg='nvim ~/.bashrc && clear && source ~/.bashrc'
alias edit_kitty_cfg='nvim ~/.config/kitty/kitty.conf'
alias edit_system_cfg='sudo nvim /etc/sysconfig'
alias edit_nvim_cfg='nvim ~/.config/nvim/lua/user'
alias darch_rebuild='sudo /home/gorciu/Desktop/PROJECTS/darch/target/debug/darch'

# -- utils
change_hypr_wallpaper() {
    file="$1"

    [ -f "$file" ] || { echo "File not found"; return 1; }

    ext="${file##*.}"
    ext="$(printf '%s\n' "$ext" | tr 'A-Z' 'a-z')"

    case "$ext" in
        jpg|jpeg|png|webp|gif)
            pkill mpvpaper 2>/dev/null

            if ! pgrep -x swww-daemon >/dev/null; then
                swww-daemon >/dev/null 2>&1 &
                disown
                sleep 0.1
            fi

            swww img "$file"
            ;;
        mp4|mkv|webm|avi)
            pkill mpvpaper 2>/dev/null
            pkill swww-daemon 2>/dev/null

            mpvpaper -f -o "--loop --no-audio" '*' "$file"
            ;;
        *)
            echo "Unsupported file type: .$ext"
            return 1
            ;;
    esac
}
alias notifications_test='notify-send -u low "siema" "urgency: low" && notify-send -u normal "siema" "urgency: normal" && notify-send -u critical "siema" "urgency: critical"'

# -- enviorement
export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"

# -- prompts
#PS1='\n\e[0;93m\u\e[97m@\e[0;93m\h\e[0;97m:\e[0;93m\w\e[0m \$ '
PS1='\n\e[38;2;255;159;0m\u\e[97m@\e[38;2;255;159;0m\h\e[0;97m:\e[38;2;255;159;0m\w\e[0m \$ '

# -- inits
eval "$(zoxide init bash)"

# -- begin
fastfetch 
