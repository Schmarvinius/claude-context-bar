# claude-context-bar

A custom status line for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that shows context window usage as a visual progress bar.

```
Context: [████████████░░░░░░░░] 60%
```

## Quick Install

```bash
git clone https://github.com/Schmarvinius/claude-context-bar.git
cd claude-context-bar
./install.sh
```

Then restart Claude Code.

## What It Does

Adds a live progress bar to the Claude Code status line showing how much of the context window is in use. Helps you know when it's time to run `/compact`.

| Usage   | Meaning  |
|---------|----------|
| 0-60%   | Healthy  |
| 60-80%  | Caution  |
| 80-90%  | Warning  |
| 90-100% | Critical |

The included skill also makes Claude proactively suggest `/compact` when context exceeds 75%.

## Manual Install

If you prefer to install manually:

1. Copy the script:
   ```bash
   cp context-bar.sh ~/.claude/context-bar.sh
   chmod +x ~/.claude/context-bar.sh
   ```

2. Copy the skill:
   ```bash
   cp -r skills/context-bar ~/.claude/skills/
   ```

3. Add this to your `~/.claude/settings.json`:
   ```json
   {
     "statusLine": {
       "type": "command",
       "command": "~/.claude/context-bar.sh"
     }
   }
   ```

4. Restart Claude Code.

## Uninstall

```bash
cd claude-context-bar
./uninstall.sh
```

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI
- `bash`
- `jq` (for automatic settings.json configuration; manual install works without it)

## How It Works

Claude Code's [`statusLine`](https://docs.anthropic.com/en/docs/claude-code) setting supports running a shell command that receives JSON with context window stats on stdin. The `context-bar.sh` script reads the `context_window.used_percentage` field and renders it as a 20-character block progress bar.

## License

MIT
