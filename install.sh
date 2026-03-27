#!/bin/bash
set -e

CLAUDE_DIR="$HOME/.claude"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing claude-context-bar..."

# Ensure ~/.claude exists
mkdir -p "$CLAUDE_DIR/skills"

# Copy the status line script
cp "$SCRIPT_DIR/context-bar.sh" "$CLAUDE_DIR/context-bar.sh"
chmod +x "$CLAUDE_DIR/context-bar.sh"
echo "  Copied context-bar.sh -> $CLAUDE_DIR/context-bar.sh"

# Copy the skill
cp -r "$SCRIPT_DIR/skills/context-bar" "$CLAUDE_DIR/skills/"
echo "  Copied skill -> $CLAUDE_DIR/skills/context-bar/"

# Configure settings.json
SETTINGS="$CLAUDE_DIR/settings.json"

if [ -f "$SETTINGS" ]; then
    # Check if statusLine is already configured
    if grep -q '"statusLine"' "$SETTINGS" 2>/dev/null; then
        echo "  statusLine already present in settings.json - skipping config update."
        echo "  (If you want to overwrite, remove the statusLine entry and re-run.)"
    elif command -v jq &>/dev/null; then
        cp "$SETTINGS" "$SETTINGS.backup"
        echo "  Backed up settings.json -> settings.json.backup"
        jq '. + {"statusLine": {"type": "command", "command": "~/.claude/context-bar.sh"}}' "$SETTINGS.backup" > "$SETTINGS"
        echo "  Added statusLine config to settings.json"
    else
        echo ""
        echo "  jq not found. Please add this manually to $SETTINGS:"
        echo '  "statusLine": {'
        echo '    "type": "command",'
        echo '    "command": "~/.claude/context-bar.sh"'
        echo '  }'
    fi
else
    # Create a minimal settings.json
    cat > "$SETTINGS" <<'EOF'
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/context-bar.sh"
  }
}
EOF
    echo "  Created $SETTINGS with statusLine config"
fi

echo ""
echo "Done! Restart Claude Code to see the context bar."
