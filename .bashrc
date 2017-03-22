alias grep='grep --color'
alias tmux=tmux2
alias testify='testify -v --summary'

export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

if [[ $TMUX ]]; then
    PROMPT_COMMAND='eval "$(~/bin/tmux-env)"; '"$PROMPT_COMMAND"
fi
