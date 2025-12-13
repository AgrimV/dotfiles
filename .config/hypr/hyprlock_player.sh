#!/usr/bin/bash

set -Eeuo pipefail

# Player priority order
PREFERRED_PLAYERS="spotify,firefox"

# Check if command exists
have() { command -v "$1" >/dev/null 2>&1; }

select_player() {
  if have playerctl && playerctl -p "$PREFERRED_PLAYERS" status >/dev/null 2>&1; then
    echo "$PREFERRED_PLAYERS"
  else
    echo ""
  fi
}

# Get metadata from active player
get_metadata() {
  local key="$1"
  local fmt="{{ $key }}"
  local player
  player="$(select_player)"

  if [[ -n "$player" ]]; then
    playerctl -p "$player" metadata --format "$fmt" 2>/dev/null || true
  else
    playerctl metadata --format "$fmt" 2>/dev/null || true
  fi
}

# Playing/Paused/Stopped
get_status() {
  local player
  player="$(select_player)"

  if [[ -n "$player" ]]; then
    playerctl -p "$player" status 2>/dev/null || true
  else
    playerctl status 2>/dev/null || true
  fi
}

# Truncate title
trim_string() {
  local str="${1:-}"
  local max_len="${2:-30}"
  local str_len=${#str}

  if ((str_len <= max_len)); then
    printf '%s' "$str"
  else
    printf '%s…' "${str:0:max_len}"
  fi
}

# Convert microseconds to mm:ss format
microseconds_to_mmss() {
  local us="$1"

  [[ "$us" =~ ^[0-9]+$ ]] || {
    printf "0:00"
    return
  }

  local seconds=$((us / 1000000))
  printf '%d:%02d' $((seconds / 60)) $((seconds % 60))
}

get_track_length() {
  local us
  us="$(get_metadata 'mpris:length')"

  if [[ -z "$us" || "$us" == "0" ]]; then
    printf '0:00'
  else
    microseconds_to_mmss "$us"
  fi
}

get_current_position() {
  local us
  local player
  player="$(select_player)"

  if [[ -n "$player" ]]; then
    us="$(playerctl -p "$player" position 2>/dev/null | awk '{print int($1 * 1000000)}')" || true
  else
    us="$(playerctl position 2>/dev/null | awk '{print int($1 * 1000000)}')" || true
  fi

  if [[ -z "$us" || "$us" == "0" ]]; then
    printf '0:00'
  else
    microseconds_to_mmss "$us"
  fi
}

# Get track progress as x:xx/y:yy
get_track_progress() {
  local current_position
  local track_length

  current_position="$(get_current_position)"
  track_length="$(get_track_length)"
  
  printf "%s / %s" "$current_position" "$track_length"
}

get_status_icon() {
  case "$(get_status | tr '[:upper:]' '[:lower:]')" in
  playing)
    printf '󰏤'
    ;;
  paused)
    printf '󰐊'
    ;;
  stopped | *)
    printf '󰓛'
    ;;
  esac
}

get_active_player() {
  local active_player=""
  local player
  player="$(select_player)"

  if [[ -n "$player" ]]; then
    active_player="$(playerctl -p "$player" -l 2>/dev/null | head -n1)"
  else
    active_player="$(playerctl -l 2>/dev/null | head -n1)"
  fi

  printf '%s' "$active_player"
}

# Get formatted player name with icon
get_player_display() {
  local player
  player="$(get_active_player)"

  case "${player,,}" in
  spotify*)
    printf '󰓇 '
    ;;
  firefox*)
    printf '󰈹 '
    ;;
  *)
    printf '? '
    ;;
  esac
}


# CLI
case "${1:-}" in
--title)
  title="$(get_metadata 'xesam:title')"
  printf '%s\n' "$(trim_string "${title:-Nothing Playing}" 29)"
  ;;

--artist)
  artist="$(get_metadata 'xesam:artist')"
  printf '%s\n' "$(trim_string "${artist:-}" 26)"
  ;;

--status)
  printf '%s\n' "$(get_status_icon)"
  ;;

--progress)
  printf '%s\n' "$(get_track_progress)"
  ;;

--player)
  printf '%s\n' "$(get_player_display)"
  ;;

--help | *)
  cat <<EOF
Usage: $(basename "$0") [OPTION]

Music player information for Hyprlock.

Options:
  --title         Display track title (truncated to 29 chars)
  --artist        Display artist name (truncated to 26 chars)
  --status        Display play/pause/stop icon
  --progress      Display track progress
  --player        Display player icon
  --help          Show this help message

Examples:
  $(basename "$0") --title
  $(basename "$0") --progress-bar

EOF
  exit 0
  ;;
esac
