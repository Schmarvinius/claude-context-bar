---
name: context-bar
description: Display context window usage as a compact progress bar
---

# Context Bar

Show context usage as a single-line progress bar.

## Output Format

```
Context: [████████████░░░░░░░░] 60% (120K/200K tokens)
```

## Thresholds

- 0-60%: Healthy
- 60-80%: Caution (suggest /compact soon)
- 80-90%: Warning
- 90-100%: Critical

## Proactive

When context > 75%, mention: "Context at X% - consider /compact"
