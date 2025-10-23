# ~/.config/fish/config.fish

# Add this to your ~/.config/fish/config.fish
fish_vi_key_bindings

set -gx DOTFILES $HOME/dotfiles
alias dotfiles='$DOTFILES/dotfiles.sh'

# Add npm global bin to PATH
set --universal fish_user_paths $HOME/.npm-global/bin $fish_user_paths

# Remove greeting
set -g fish_greeting
set -gx EDITOR nvim
set -gx PATH ~/.npm-global/bin $PATH

set -gx XDG_SESSION_TYPE wayland
set -gx XDG_CURRENT_DESKTOP sway # MangoWC is dwl-like, so sway compat works for portals
set -gx GDK_BACKEND wayland
set -gx QT_QPA_PLATFORM wayland
set -gx MOZ_ENABLE_WAYLAND 1 # For Firefox

# Abbreviations
abbr -a mkdir "mkdir -p"
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Aliases
alias vi="nvim"
alias vim="nvim"
alias ani="ani-cli"
alias lg="lazygit"
alias ld="lazydocker"
alias c="clear"
alias l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias str="sudo mount /dev/sdb3 /storage"
alias gmg2="sudo mount /dev/sdb4 /mnt/Gaming2"
alias gmg="sudo mount /dev/sda1 /mnt/Gaming1"
alias todo="cargo run --manifest-path ~/Coding/Rust/todo-list/Cargo.toml"
alias mail="neomutt"
alias nvim2="NVIM_APPNAME=nvim_2 nvim"
alias dt='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias simpvim='NVIM_APPNAME=simpvim nvim'
alias seh='sesh connect $(sesh list | fzf)'
alias rn="Rustymemo"

# You may want to remove or adapt these Nix-specific aliases for Arch
# alias rebuild="sudo nixos-rebuild switch --flake ~/nixos#nixos"
# alias hms="home-manager switch"
# alias update="sudo nix flake update --flake ~/nixos"
# alias cleanup="sudo nix-collect-garbage -d"

# For Arch, you might want to replace them with these:
alias pacup="sudo pacman -Syu"
alias pacsearch="pacman -Ss"
alias pacinstall="sudo pacman -S"
alias pacremove="sudo pacman -R"
alias pacclean="sudo pacman -Sc"
alias weather="curl wttr.in"

# Fish colors (Dracula theme)
set -U fish_color_normal f8f8f2
set -U fish_color_command 8be9fd
set -U fish_color_quote f1fa8c
set -U fish_color_redirection f8f8f2
set -U fish_color_end ffb86c
set -U fish_color_error ff5555
set -U fish_color_param bd93f9
set -U fish_color_comment 6272a4
set -U fish_color_match --background=brblue
set -U fish_color_selection --background=44475a
set -U fish_color_search_match --background=44475a
set -U fish_color_history_current --bold
set -U fish_color_operator 50fa7b
set -U fish_color_escape ff79c6
set -U fish_color_cwd 50fa7b
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion 6272a4
set -U fish_color_user 8be9fd
set -U fish_color_host bd93f9
set -U fish_color_cancel ff5555 --reverse
set -U fish_pager_color_background
set -U fish_pager_color_prefix 8be9fd
set -U fish_pager_color_progress 6272a4
set -U fish_pager_color_completion f8f8f2
set -U fish_pager_color_description 6272a4
set -U fish_pager_color_selected_background --background=44475a
set -U fish_pager_color_selected_prefix 8be9fd
set -U fish_pager_color_selected_completion f8f8f2
set -U fish_pager_color_selected_description 6272a4
set -U fish_color_host_remote
set -U fish_color_keyword
set -U fish_pager_color_secondary_completion
set -U fish_color_option
set -U fish_pager_color_secondary_background
set -U fish_pager_color_secondary_prefix
set -U fish_pager_color_secondary_description

# Yazi file manager function
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Initialize starship prompt if installed
if type -q starship
    starship init fish | source
end

# Initialize zoxide if installed
if type -q zoxide
    zoxide init fish | source
end

# Created by `pipx` on 2025-04-30 19:42:41
set PATH $PATH /home/simpa/.local/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# opencode
fish_add_path /home/simpa/.opencode/bin

# pnpm
set -gx PNPM_HOME "/home/simpa/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
