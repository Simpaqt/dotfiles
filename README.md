# Dotfiles

Personal dotfiles for Arch Linux with Wayland setup.

## Structure

- `fish/` - Fish shell configuration
- `ghostty/` - Ghostty terminal emulator config
- `mango/` - MangoWC compositor configuration
- `nix/` - Nix package manager settings
- `nvim/` - Neovim configuration (LazyVim)

## Installation

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The install script will:

- Install base packages (fish, neovim, yazi, starship, etc.)
- Install yay AUR helper
- Set up Wayland screensharing with xdg-desktop-portal
- Configure portals for Discord screensharing
- Symlink dotfiles using GNU Stow
- Set fish as default shell

## Manual Setup

If you already have the dotfiles cloned, symlink individual configs:

```bash
cd ~/dotfiles
stow fish
stow nvim
stow ghostty
stow mango
```

## Requirements

- Arch Linux
- Wayland compositor (MangoWC or compatible)
- Base-devel and git

## Notes

- Dotfiles are managed with GNU Stow
- Changes to configs in `~/.config/` will reflect in `~/dotfiles/`
- Log out and back in after installation for all changes to take effect
