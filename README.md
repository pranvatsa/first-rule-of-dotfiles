# first-rule-of-dotfiles

First rule of dotfiles : You don't talk about dotfiles.

## Prerequisites

- CachyOS/Arch-based system with `zsh`, `git`, and `curl`.
- [Oh My Zsh](https://ohmyz.sh/) is installed by `install.sh` if missing.

## Quick install

```bash
curl -fsSL https://raw.githubusercontent.com/pranvatsa/first-rule-of-dotfiles/main/install.sh | bash
exec zsh
```

The installer prompts for the clone path and defaults to
`~/gitproj/first-rule-of-dotfiles`.

## Manual setup

```bash
git clone https://github.com/pranvatsa/first-rule-of-dotfiles.git $HOME/gitproj/first-rule-of-dotfiles
export DOTFILES=$HOME/gitproj/first-rule-of-dotfiles

ln -sf $DOTFILES/.zshrc ~/.zshrc
mkdir -p ~/.oh-my-zsh/custom
ln -sf $DOTFILES/zsh-custom/aliases.zsh ~/.oh-my-zsh/custom/aliases.zsh
mkdir -p ~/.config/opencode
ln -sf $DOTFILES/AGENTS.md ~/.config/opencode/AGENTS.md

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

exec zsh
```

## Post-setup

`.zshrc` exports `$DOTFILES` resolved through the `~/.zshrc` symlink, so it stays
correct if the repo moves. Machine-local blocks (`opencode`, `pyenv`, `fnm`,
`envman`, `lesspipe`, ssh-agent) are guarded with existence checks — they only
activate if the tool is installed.

For personal secrets or machine-specific overrides, create `~/.zshrc.local` — it's auto-sourced by `.zshrc` and excluded from version control via `.gitignore`.

`AGENTS.md` is the machine and toolchain reference. `install.sh` symlinks it to
`~/.config/opencode/AGENTS.md`, so OpenCode loads it in every session.

## Toolchains

Node.js (fnm, LTS only), Python (uv), and the `~/.local/bin` PATH setup are
documented in [`AGENTS.md`](AGENTS.md).

## Updating

```bash
cd $DOTFILES
git add -A
git commit -m "your message"
git push
```
