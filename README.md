# Dotfiles

A collection of various config files. The repo is intended to be symlinked into the user's `$HOME` directory.

Used as default for [env-setup](https://github.com/Luciditi/env-setup).

## Files
- [`.bash_profile`](.bash_profile): Bash entrypoint; bootstraps `.shell/bash/.profile`.
- [`.cheat/`](.cheat): [Cheat](https://github.com/chrisallenlane/cheat) cheatsheets configuration.
- [`.direnvrc`](.direnvrc): [direnv](https://github.com/direnv/direnv) customization script.
- [`.gitconfig`](.gitconfig): User-level Git configuration (includes handy aliases).
- [`.git_template/`](.git_template): Scaffolding and default hooks for new Git repositories.
- [`.gitignore_global`](.gitignore_global): Global Git ignore patterns.
- [`.inputrc`](.inputrc): Readline configuration for keyboard mappings in the terminal.
- [`.macos`](.macos): macOS system defaults configuration script.
- [`.notags`](.notags): Marker to exclude home directory indexing by tags/ctags.
- [`.p10k.zsh`](.p10k.zsh): [Powerlevel10k](https://github.com/romkatv/powerlevel10k) configuration.
- [`.plugins.vimrc`](.plugins.vimrc): Vim plugin declarations via `vim-plug`.
- [`.shell/`](.shell): Core shell configuration directory:
  - [`common/`](.shell/common): Shared, POSIX-compatible aliases and functions.
  - [`bash/`](.shell/bash): Bash-specific configuration, completions, and aliases.
  - [`zsh/`](.shell/zsh): Zsh-specific configuration, completions, aliases, and antigen scripts.
  - [`bin/`](.shell/bin): Shared CLI executables added to the system `PATH`.
- [`.vim/`](.vim): Vim configuration directory (backups, swaps, undos, templates).
- [`.vimrc`](.vimrc): Main Vim settings, mappings, and plugin configurations.
- [`.zshrc`](.zshrc): Zsh entrypoint; loads PL10K and `.shell/zsh/.profile`.
- [`README.md`](README.md): Temet nosce.
