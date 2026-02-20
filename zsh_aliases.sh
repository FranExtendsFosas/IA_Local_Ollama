# Configuración para hablar con la IA sin usar comillas en consola
function _ia_fn() { sgpt "$*" }
function _cmd_fn() { sgpt --shell "$*" }
function _chat_fn() { sgpt --repl "$*" }
function _cod_fn() { sgpt --code "$*" }

# Alias mágicos que evitan que ZSH procese los signos de interrogación y otros símbolos (*, etc.)
alias ia="noglob _ia_fn"
alias cmd="noglob _cmd_fn"
alias haz="noglob _cmd_fn"
alias chat="noglob _chat_fn"
alias cod="noglob _cod_fn"

# Shell-GPT integration ZSH (Generador rápido con atajo de teclado)
_sgpt_zsh() {
if [[ -n "$BUFFER" ]]; then
    _sgpt_prev_cmd=$BUFFER
    BUFFER+="⌛"
    zle -I && zle redisplay
    BUFFER=$(sgpt --shell --no-interaction "$_sgpt_prev_cmd")
    zle end-of-line
fi
}
zle -N _sgpt_zsh
bindkey '^g' _sgpt_zsh
