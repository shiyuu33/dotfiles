#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "?"')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

# progress bar (10 characters)
FILLED=$((PCT * 10 / 100))
EMPTY=$((10 - FILLED))
BAR=$(printf "%${FILLED}s" | tr ' ' '▓')$(printf "%${EMPTY}s" | tr ' ' '░')

COST_FMT=$(printf '$%.3f' "$COST")

echo "[$MODEL] ${BAR} ${PCT}% ctx | ${COST_FMT}"
