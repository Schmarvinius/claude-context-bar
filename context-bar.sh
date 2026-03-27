#!/bin/bash
input=$(cat)
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

# Build 20-char progress bar
FILLED=$((PCT / 5))
EMPTY=$((20 - FILLED))
BAR="$(printf '%*s' $FILLED '' | tr ' ' '█')$(printf '%*s' $EMPTY '' | tr ' ' '░')"

echo "Context: [$BAR] $PCT%"
