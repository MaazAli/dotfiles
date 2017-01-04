grep='grep --color'
tmux=tmux2


if [[ $TMUX ]]; then
    PROMPT_COMMAND='eval "$(/nail/scripts/tmux-env)"; '"$PROMPT_COMMAND"
fi
