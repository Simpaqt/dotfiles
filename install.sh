#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
  echo -e "${GREEN}[+]${NC} $1"
}

print_error() {
  echo -e "${RED}[!]${NC} $1"
}

print_warning() {
  echo -e "${YELLOW}[*]${NC} $1"
}

# Check if running as root
if [ "$EUID" -eq 0 ]; then
  print_error "Please do not run this script as root"
  exit 1
fi

print_status "Starting Arch Linux dotfiles installation..."

# Update system
print_status "Updating system packages..."
sudo pacman -Syu --noconfirm

# Install base-devel if not present (required for yay)
print_status "Installing base-devel and git..."
sudo pacman -S --needed --noconfirm base-devel git

# Install yay AUR helper
if ! command -v yay &>/dev/null; then
  print_status "Installing yay AUR helper..."
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ~
  print_status "yay installed successfully!"
else
  print_status "yay is already installed"
fi

# Install packages from official repos
print_status "Installing packages from official repositories..."
sudo pacman -S --needed --noconfirm \
  github-cli \
  fish \
  eza \
  zoxide \
  starship \
  yazi \
  nix \
  neovim

# Install packages from AUR
print_status "Installing AUR packages..."
yay -S --needed --noconfirm \
  wmenu \
  ttf-jetbrains-mono-nerd \
  mangowc-git

# Install Wayland screensharing dependencies
print_status "Installing Wayland screensharing dependencies..."
sudo pacman -S --needed --noconfirm \
  pipewire \
  wireplumber \
  xdg-desktop-portal \
  xdg-desktop-portal-wlr \
  xdg-desktop-portal-gtk \
  grim \
  slurp

# Additional useful Wayland screensharing tools
print_status "Screensharing dependencies installed!"

# Clone or update dotfiles
print_status "Setting up dotfiles..."
DOTFILES_REPO=""
read -p "Enter your dotfiles repository URL (or press Enter to skip): " DOTFILES_REPO

if [ -n "$DOTFILES_REPO" ]; then
  DOTFILES_DIR="$HOME/dotfiles"

  if [ -d "$DOTFILES_DIR" ]; then
    print_warning "Dotfiles directory already exists. Pulling latest changes..."
    cd "$DOTFILES_DIR"
    git pull
  else
    print_status "Cloning dotfiles repository..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
  fi

  # Backup existing config
  if [ -d "$HOME/.config" ]; then
    print_status "Backing up existing .config to .config.backup..."
    cp -r "$HOME/.config" "$HOME/.config.backup.$(date +%Y%m%d_%H%M%S)"
  fi

  # Create .config if it doesn't exist
  mkdir -p "$HOME/.config"

  # Copy dotfiles to .config
  print_status "Copying dotfiles to ~/.config/..."
  if [ -d "$DOTFILES_DIR/.config" ]; then
    cp -r "$DOTFILES_DIR/.config/"* "$HOME/.config/"
  elif [ -d "$DOTFILES_DIR/config" ]; then
    cp -r "$DOTFILES_DIR/config/"* "$HOME/.config/"
  else
    # If dotfiles are in root of repo
    cp -r "$DOTFILES_DIR/"* "$HOME/.config/"
  fi

  print_status "Dotfiles copied successfully!"
else
  print_warning "Skipping dotfiles setup"
fi

# Set fish as default shell
if command -v fish &>/dev/null; then
  print_status "Setting fish as default shell..."
  if [ "$SHELL" != "$(which fish)" ]; then
    chsh -s "$(which fish)"
    print_status "Default shell changed to fish (restart required)"
  else
    print_status "Fish is already the default shell"
  fi
fi

# Enable and start pipewire services
print_status "Enabling pipewire services..."
systemctl --user enable --now pipewire pipewire-pulse wireplumber

print_status "Installation complete!"
echo ""
print_status "Installed packages:"
echo "  - git, github-cli, fish, eza, zoxide, starship"
echo "  - yazi, nix, neovim, wmenu"
echo "  - JetBrains Mono Nerd Font"
echo "  - Wayland screensharing: pipewire, xdg-desktop-portal, grim, slurp"
echo ""
print_warning "Please log out and log back in for all changes to take effect"
print_warning "For screensharing to work properly, ensure your compositor supports wlr-screencopy protocol"
