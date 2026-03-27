#!/bin/bash
set -e

CLAUDE_DIR="$HOME/.claude"

echo "Uninstalling claude-context-bar..."

# Remove the script
if [ -f "$CLAUDE_DIR/context-bar.sh" ]; then
    rm "$CLAUDE_DIR/context-bar.sh"
    echo "  Removed $CLAUDE_DIR/context-bar.sh"
else
    echo "  context-bar.sh not found - skipping"
fi

# Remove the skill
if [ -d "$CLAUDE_DIR/skills/context-bar" ]; then
    rm -rf "$CLAUDE_DIR/skills/context-bar"
    echo "  Removed $CLAUDE_DIR/skills/context-bar/"
else
    echo "  Skill directory not found - skipping"
fi

# Remove statusLine from settings.json
SETTINGS="$CLAUDE_DIR/settings.json"

if [ -f "$SETTINGS" ] && grep -q '"statusLine"' "$SETTINGS" 2>/dev/null; then
    if command -v jq &>/dev/null; then
        cp "$SETTINGS" "$SETTINGS.backup"
        echo "  Backed up settings.json -> settings.json.backup"
        jq 'del(.statusLine)' "$SETTINGS.backup" > "$SETTINGS"
        echo "  Removed statusLine from settings.json"
    else
        echo ""
        echo "  jq not found. Please manually remove the statusLine entry from $SETTINGS"
    fi
else
    echo "  No statusLine config found in settings.json - skipping"
fi

echo ""
echo "Done! Restart Claude Code to apply changes."
