# AGENTS.md — first-rule-of-dotfiles

This repository is the source of truth for setting up this machine. Follow it
on every new laptop. OpenCode loads it globally through the
`~/.config/opencode/AGENTS.md` symlink. Do not copy these rules into other
project `AGENTS.md` files.

## Structure

- Set `$DOTFILES` to the repo root (for example
  `export DOTFILES=$HOME/gitproj/first-rule-of-dotfiles`).
- `~/.zshrc` is symlinked from `$DOTFILES/.zshrc`. An edit changes the live
  shell immediately.
- `~/.oh-my-zsh/custom/aliases.zsh` is symlinked from
  `$DOTFILES/zsh-custom/aliases.zsh`.
- `~/.config/opencode/AGENTS.md` is symlinked from `$DOTFILES/AGENTS.md`, so
  this file applies to every OpenCode session.

## Setup on a fresh machine

Run `install.sh`. It clones the repo, installs Oh My Zsh, creates the symlinks,
and installs the custom plugins.

## Machine

- OS: CachyOS (Arch-based). Shell: zsh.
- No passwordless sudo. Do not run `sudo`; it cannot authenticate here.
- User tools live in `~/.local/bin`. That directory is on the PATH of
  interactive shells only.

## Activate the toolchain first

Agent shells are non-interactive and do not read `~/.zshrc`, so `node`, `npm`,
`uv`, and `fnm` are absent from the default PATH. Activate them before you use
the toolchain.

Option A, set the PATH in the current shell:

```sh
export PATH="$HOME/.local/bin:$HOME/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd --shell zsh)"
```

Option B, run one command through a login shell:

```sh
zsh -lic '<command>'
```

Option B prints startup noise and may print `can't change option: zle` when no
TTY is present. The message is harmless.

## Toolchain rules

- Node.js and npm come from fnm. Do not use a system Node.
  - Use the LTS Node only. Do not install or keep other versions. Install it
    with `fnm install --lts` and select it with `fnm default lts-latest`.
  - A repository `.node-version` selects its Node. The `--use-on-cd` flag above
    applies it. Plain `fnm env` does not, so run `fnm use` in that case.
  - Use `npx` for one-off packages.
- Python comes from uv. Use `uv run`, `uv venv`, `uv pip install`, `uvx <tool>`,
  and `uv python install`.
  - Never use system `pip`, `pip install --user`, or the system Python for
    project dependencies.
- Prefer a static binary or an installer that writes to `~/.local/bin` over a
  system package. Prefer `uv tool install` for Python CLI tools.
- Never write secrets into a repository. Put machine-local values in
  `~/.zshrc.local` or a gitignored file.

## Security

- Never commit API keys, tokens, or secrets. Before any push, grep for patterns
  like `API_KEY`, `SECRET`, `TOKEN`, `sk-`, `ghp_` in staged files.
- The `envman` block in `.zshrc` sources an external file. Verify it does not
  contain secrets before you commit a change to it.
- Machine-local paths must not be committed as-is if the repo is shared. Use
  `$HOME` or `$DOTFILES` instead.
- Personal secrets go in `~/.zshrc.local`. It is gitignored and sourced by
  `.zshrc`.

## Watch out for

- `.zshrc` machine-local blocks (`opencode`, `pyenv`, `envman`, `lesspipe`) are
  guarded with existence checks, so they are safe on any machine.
- The `plugins` line in `.zshrc` references plugins that must be present in
  `$ZSH/custom/plugins/`. The repo does not bundle them.
- If you move the repo directory, all symlinks break. Update them with `ln -sf`
  after moving.

## Communication style

Keep it brief. Code comments, commit messages, PR descriptions, and replies are
short and to the point. Start every commit subject with a type: `feat`, `fix`,
`docs`, `chore`, `refactor`, `test`, `style`, or `perf`. Never use the author's
name. No verbosity unless there is a real need for it.
