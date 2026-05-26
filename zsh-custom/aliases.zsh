# Canonical source: $DOTFILES/zsh-custom/aliases.zsh
# (symlinked to ~/.oh-my-zsh/custom/aliases.zsh, loads after OMZ plugins,
# so these intentionally override plugin defaults where noted.)

# -----------------------------
# Shell
# -----------------------------
alias refresh-shell='exec zsh'
alias c='clear'

# Trailing space lets sudo expand the following alias (e.g. `sudo ll`).
alias sudo='sudo '

# -----------------------------
# Arch / CachyOS (pacman)
# -----------------------------
if command -v pacman >/dev/null 2>&1; then
  alias update='sudo pacman -Syu'
  alias cleanup="sudo pacman -Rns \$(pacman -Qtdq 2>/dev/null)"
  alias rmpkg='sudo pacman -Rns'
  alias cleanch='sudo pacman -Scc'
  alias fixpacman='sudo rm -f /var/lib/pacman/db.lck'
  alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' 2>/dev/null | sort | tail -200 | nl"
  alias jctl='journalctl -p 3 -xb'
fi

# -----------------------------
# Debian/Ubuntu (apt) — only where apt exists
# -----------------------------
if command -v apt-get >/dev/null 2>&1; then
  alias sau='sudo apt update'
  alias saug='sudo apt upgrade'
  alias sauu='sudo apt update && sudo apt upgrade'
fi

# -----------------------------
# Docker / Kubernetes (only where installed)
# -----------------------------
if command -v docker >/dev/null 2>&1; then
  alias d='docker'
fi
if command -v kubectl >/dev/null 2>&1; then
  alias k='kubectl'
  alias kctx='kubectl config current-context'
  alias kns='kubectl config view --minify | grep namespace:'
  alias kpods='kubectl get pods'
  alias ksvc='kubectl get svc'
fi

# -----------------------------
# Git
# NOTE: OMZ git plugin already defines ga/gc/gl/gp. We override ga/gc
# deliberately (plain verbs, no --verbose); gl stays as the plugin's
# `git pull` — use glog for the graph log.
# -----------------------------
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit -v'
alias gp='git push'
alias glog='git log --oneline --graph --decorate'

# -----------------------------
# File listing
# -----------------------------
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# -----------------------------
# Process / Monitoring
# -----------------------------
# psg/findpid: case-insensitive process search, never matches itself.
psg() { ps aux | grep -iv '[g]rep' | grep -i -- "${*:-.}"; }
alias findpid='psg'

pids() { ps -ef "$@"; }
ports() { ss -tuln "$@"; }          # add -p with sudo to see PIDs: `sudo ss -tulnp`
sudo-ports() { sudo ss -tulnp "$@"; }

# Linux procps top sort keys (e.g. `topc`, `topm`).
alias topc='top -o %CPU'
alias topm='top -o %MEM'

# killpid: usage `killpid [-SIGNAL] <pid...>` with a confirmation, no forced sudo.
killpid() {
  if [ $# -eq 0 ]; then
    echo "usage: killpid [-SIGNAL] <pid...>" >&2
    return 1
  fi
  echo "About to run: kill $*"
  printf 'Confirm? [y/N] '
  read -r ans
  case "$ans" in
    [yY]*) kill "$@" ;;
    *) echo 'Aborted.' ;;
  esac
}

if command -v htop >/dev/null 2>&1; then
  alias ht='htop'
fi
if command -v btop >/dev/null 2>&1; then
  alias bt='btop'
fi

# -----------------------------
# Networking
# -----------------------------
alias myip='curl -s --max-time 5 ifconfig.me; echo'
alias localip='ip -brief addr show'

# -----------------------------
# Disk usage
# -----------------------------
alias dfh='df -h'
# duh: human sizes sorted; -- guards against filenames starting with -.
duh() { du -sh -- * .[!.]* 2>/dev/null | sort -h; }

# -----------------------------
# Desktop notifications (only where notify-send exists)
# -----------------------------
if command -v notify-send >/dev/null 2>&1; then
  alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(fc -ln -1 | sed '\''s/[;&|]\s*alert$//'\'')"'
fi
