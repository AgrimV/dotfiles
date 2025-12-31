#!/usr/bin/bash

set -Eeuo pipefail

# Player priority order
PREFERRED_PLAYERS="spotify,firefox"

# Check if command exists
have() { command -v "$1" >/dev/null 2>&1; }

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

trim_string() {
  local str="${1:-}"
  local max_len="${2:-30}"
  local str_len=${#str}

  if ((str_len <= max_len)); then
    printf '%s' "$str"
  else
    printf '%s…' "${str:0:max_len - 1}"
  fi
}

select_player() {
  if have playerctl && playerctl -p "$PREFERRED_PLAYERS" status >/dev/null 2>&1; then
    echo "$PREFERRED_PLAYERS"
  else
    echo ""
  fi
}

get_status() {
  local player
  player="$(select_player)"

  if [[ -n "$player" ]]; then
    playerctl -p "$player" status 2>/dev/null || true
  else
    playerctl status 2>/dev/null || true
  fi
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
  --player        Display player source icon
  --help          Show this help message

Examples:
  $(basename "$0") --title

EOF
  exit 0
  ;;
esac
