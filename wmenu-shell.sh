#!/bin/bash

CACHE_FILE="$HOME/.cache/wmenu-apps.cache"
CACHE_MAX_AGE=3600 # Rebuild cache after 1 hour (in seconds)

DESKTOP_DIRS=(
  "/usr/share/applications"
  "/usr/local/share/applications"
  "$HOME/.local/share/applications"
)

# Get PATH binaries
get_path_binaries() {
  IFS=:
  for dir in $PATH; do
    [[ -d "$dir" ]] && ls -1 "$dir" 2>/dev/null
  done
}

# Parse desktop files and extract Name and Exec fields
parse_desktop_files() {
  for dir in "${DESKTOP_DIRS[@]}"; do
    [[ -d "$dir" ]] || continue

    for file in "$dir"/*.desktop; do
      [[ -f "$file" ]] || continue

      # Skip hidden/NoDisplay entries
      if grep -q "^NoDisplay=true" "$file" 2>/dev/null; then
        continue
      fi

      name=""
      exec=""

      while IFS='=' read -r key value; do
        case "$key" in
        "Name")
          [[ -z "$name" ]] && name="$value"
          ;;
        "Exec")
          exec="$value"
          ;;
        esac
      done <"$file"

      if [[ -n "$name" && -n "$exec" ]]; then
        # Remove field codes (%f, %F, %u, %U, etc.)
        exec=$(echo "$exec" | sed 's/%[fFuUdDnNickvm]//g')
        echo "desktop|$name|$exec"
      fi
    done
  done
}

# Build the app list
build_cache() {
  {
    get_path_binaries | while read -r bin; do
      echo "path|$bin|$bin"
    done
    parse_desktop_files
  } | sort -u -t'|' -k2 >"$CACHE_FILE"
}

# Check if cache needs rebuilding
needs_rebuild() {
  if [[ ! -f "$CACHE_FILE" ]]; then
    return 0
  fi

  local cache_age=$(($(date +%s) - $(stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0)))
  [[ $cache_age -gt $CACHE_MAX_AGE ]]
}

# Rebuild cache if needed (in background for next run)
if needs_rebuild; then
  build_cache
fi

# Read from cache
if [[ -f "$CACHE_FILE" ]]; then
  apps=$(cat "$CACHE_FILE")
else
  # Fallback if cache doesn't exist yet
  apps=$(
    {
      get_path_binaries | while read -r bin; do
        echo "path|$bin|$bin"
      done
      parse_desktop_files
    } | sort -u -t'|' -k2
  )
fi

# Get selection from wmenu
selected=$(echo "$apps" | cut -d'|' -f2 | wmenu -l 10 -f "JetBrainsMono Nerd Font 14")

# Launch selected application
if [[ -n "$selected" ]]; then
  # Find the matching line
  line=$(echo "$apps" | grep "|$selected|" | head -n1)
  type=$(echo "$line" | cut -d'|' -f1)
  exec_cmd=$(echo "$line" | cut -d'|' -f3-)

  if [[ -n "$exec_cmd" ]]; then
    # Launch in background, fully detached
    (nohup sh -c "$exec_cmd" </dev/null >/dev/null 2>&1 &) &
    disown
  fi
fi
exit 0
