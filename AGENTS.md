# AGENTS.md — first-rule-of-dotfiles

## Structure

- Set `$DOTFILES` to the repo root (e.g. `export DOTFILES=$HOME/gitproj/first-rule-of-dotfiles`).
- `.zshrc` is symlinked from `~/.zshrc` — editing the file in the repo updates the live shell immediately.
- `zsh-custom/aliases.zsh` is symlinked from `~/.oh-my-zsh/custom/aliases.zsh`.
- Symlinks are set up with `ln -sf $DOTFILES/.zshrc ~/.zshrc` (and similarly for aliases).

## Setup on a fresh machine

Run `install.sh` — it handles clone, Oh My Zsh install, symlinks, and custom plugins interactively.

## Security

- Never commit API keys, tokens, or secrets. Before any push, grep for patterns like `API_KEY`, `SECRET`, `TOKEN`, `sk-`, `ghp_` in staged files.
- The `envman` block in `.zshrc` sources an external file — verify it doesn't contain secrets before committing any changes to it.
- Machine-local paths (hardcoded user names, absolute home dirs) should not be committed as-is if the repo is meant for sharing. Use `$HOME` or `$DOTFILES` instead.
- Personal secrets (API keys, tokens) go in `~/.zshrc.local` — it's gitignored and sourced by `.zshrc`.

## Watch out for

- `.zshrc` machine-local blocks (`opencode`, `pyenv`, `envman`, `lesspipe`) are now guarded with existence checks — safe on any machine.
- The `plugins` line in `.zshrc` references plugins that must be present in `$ZSH/custom/plugins/` — the repo does not bundle them.
- If you move the repo directory, all symlinks break. Update them with `ln -sf` after moving.
