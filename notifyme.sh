notifyme() {
  CONFIG_FILE="$HOME/.notifyme_topic"

  # Initialize
  if [[ "$1" == "init" ]]; then
    topic="job-$(openssl rand -hex 16)"
    echo "$topic" > "$CONFIG_FILE"
    export NOTIFYME_TOPIC="$topic"

    echo "Scan this QR code to subscribe:"
    qrencode -t ansiutf8 "https://ntfy.sh/$topic"
    read -p "Press enter after scanning..."

    return
  fi

  # Load topic if not already in env
  if [[ -z "$NOTIFYME_TOPIC" ]]; then
    if [[ -f "$CONFIG_FILE" ]]; then
      NOTIFYME_TOPIC=$(cat "$CONFIG_FILE")
      export NOTIFYME_TOPIC
    else
      echo "No active topic. Run: notifyme init"
      return 1
    fi
  fi

  # Determine message
  if [[ -z "$*" ]]; then
    # Get last “real” command from history, ignoring notifyme itself
    last_cmd=$(history | tac | grep -m1 -v "notifyme" | sed 's/^[ ]*[0-9]\+[ ]*//')
    message="Job '$last_cmd' finished"
  else
    message="$*"
  fi

  # Send notification
  curl -s -d "$message" "https://ntfy.sh/$NOTIFYME_TOPIC" >/dev/null
}
