#!/usr/bin/env bash

SESSION="dev"
CURRENT_DIR="$(pwd)"

# Kill existing session
tmux has-session -t "$SESSION" 2>/dev/null && tmux kill-session -t "$SESSION"

# Create session - specify the start directory here to be safe
tmux new-session -d -s "$SESSION" -n "zsh" -c "$CURRENT_DIR"

# Split and immediately target NEW pane via last-pane
tmux split-window -h -l 20% -t "$SESSION:zsh"
tmux split-window -v -l 10% -t "$SESSION:zsh"

# Give tmux a moment to register the layout
sleep 0.2

# Often, using the % ID or simple index works better after a split
tmux send-keys -t "$SESSION:zsh.1" "source ~/.zshrc" C-m
tmux send-keys -t "$SESSION:zsh.2" "btop" C-m
tmux send-keys -t "$SESSION:zsh.3" "ctop" C-m

# Create other windows
tmux new-window -t "$SESSION" -n "gemini"
tmux new-window -t "$SESSION" -n "vscode" -c "$CURRENT_DIR"
tmux new-window -t "$SESSION" -n "pi"

# Send commands
tmux send-keys -t "$SESSION:gemini" "gemini" C-m
tmux send-keys -t "$SESSION:vscode" "code ." C-m
tmux send-keys -t "$SESSION:pi" "pi" C-m

# Focus back to zsh
tmux select-window -t "$SESSION:zsh"

# Attach
tmux attach-session -t "$SESSION"
