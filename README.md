# first-rule-of-dotfiles

First rule of dotfiles : You don't talk about dotfiles.

## Prerequisites

- [Oh My Zsh](https://ohmyz.sh/) installed

## Quick install

```bash
curl -fsSL https://raw.githubusercontent.com/pranvatsa/first-rule-of-dotfiles/main/install.sh | bash
exec zsh
```

## Manual setup

```bash
git clone git@github.com:pranvatsa/first-rule-of-dotfiles.git $HOME/gitproj/first-rule-of-dotfiles
export DOTFILES=$HOME/gitproj/first-rule-of-dotfiles

ln -sf $DOTFILES/.zshrc ~/.zshrc
mkdir -p ~/.oh-my-zsh/custom
ln -sf $DOTFILES/zsh-custom/aliases.zsh ~/.oh-my-zsh/custom/aliases.zsh

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

exec zsh
```

## Post-setup

Machine-local blocks (opencode, pyenv, envman, lesspipe) are guarded with existence checks — they only activate if the tool is installed.

For personal secrets or machine-specific overrides, create `~/.zshrc.local` — it's auto-sourced by `.zshrc` and excluded from version control via `.gitignore`.

## Updating

```bash
cd $DOTFILES
git add -A
git commit -m "your message"
git push
```
