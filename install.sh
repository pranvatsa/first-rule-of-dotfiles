#!/usr/bin/env bash
set -e

DOTFILES_REPO="git@github.com:pranvatsa/first-rule-of-dotfiles.git"

echo "==> first-rule-of-dotfiles installer"
echo ""

DEFAULT_DEST="$HOME/gitproj/first-rule-of-dotfiles"

if [ -t 0 ]; then
  read -p "Clone to [$DEFAULT_DEST]: " DEST
fi

DEST="${DEST:-$DEFAULT_DEST}"

if [ ! -d "$DEST" ]; then
  echo "==> Cloning into $DEST"
  git clone "$DOTFILES_REPO" "$DEST"
else
  echo "==> $DEST already exists, skipping clone"
fi

export DOTFILES="$DEST"

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "==> Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "==> Oh My Zsh already installed"
fi

# Symlinks
echo "==> Setting up symlinks"
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"
mkdir -p "$HOME/.oh-my-zsh/custom"
ln -sf "$DOTFILES/zsh-custom/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"

# Custom plugins
echo "==> Installing custom plugins"
PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
[ -d "$PLUGINS_DIR/zsh-autosuggestions" ] || git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
[ -d "$PLUGINS_DIR/zsh-syntax-highlighting" ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting "$PLUGINS_DIR/zsh-syntax-highlighting"

# .zshrc.local
if [ ! -f "$HOME/.zshrc.local" ]; then
  echo "==> Creating empty ~/.zshrc.local (add your secrets here — it's gitignored)"
  touch "$HOME/.zshrc.local"
fi

echo ""
echo "==> Done! Run 'exec zsh' to start."
