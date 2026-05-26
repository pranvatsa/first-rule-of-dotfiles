# ~/.config/zsh/aliases.zsh

# -----------------------------
# Shell
# -----------------------------
alias refresh-shell="source ~/.zshrc"
alias c="clear"

# -----------------------------
# Apt / System
# -----------------------------
alias sau="sudo apt update"
alias saug="sudo apt upgrade"
alias sauu="sudo apt update && sudo apt upgrade"

# -----------------------------
# Docker / Kubernetes
# -----------------------------
alias d="docker"
alias k="kubectl"

alias kctx="kubectl config current-context"
alias kns="kubectl config view --minify | grep namespace:"
alias kpods="kubectl get pods"
alias ksvc="kubectl get svc"

# -----------------------------
# Git
# -----------------------------
alias gs="git status"
alias ga="git add ."
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"

# -----------------------------
# File listing
# -----------------------------
alias ll="ls -lah"
alias la="ls -A"

# -----------------------------
# Process / Monitoring
# -----------------------------
alias psg="ps aux | grep -i"
alias pids="ps -ef"
alias ports="ss -tulnp"

alias topc="top -o %CPU"
alias topm="top -o %MEM"

alias ht="htop"
alias bt="btop"

# -----------------------------
# Networking
# -----------------------------
alias myip="curl ifconfig.me"
alias localip="ip addr show"

# -----------------------------
# Disk usage
# -----------------------------
alias duh="du -sh * | sort -h"
alias dfh="df -h"

# -----------------------------
# Color / Misc
# -----------------------------
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(fc -ln -1 | sed '\''s/[;&|]\s*alert$//'\'')"'
