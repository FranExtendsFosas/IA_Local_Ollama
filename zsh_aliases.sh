# ==========================================
# ASISTENTE INTELIGENCIA ARTIFICIAL (QWEN)
# ==========================================
# Funciones base ocultas (Aíslan y evitan falsos volcados de variables por usar espacios en los textos)
function _ia_fn() { sgpt --repl "$*" }
function _cons_fn() { sgpt "$*" }
function _cod_fn() { sgpt --code "$*" }

function _cmd_fn() { 
    echo -e "\e[1;36m🤖 Qwen está buscando el comando exacto...\e[0m"
    local cmd_crudo=$(sgpt --role "Shell Command Generator" "$*")
    # Fuerza el procesado de caracteres especiales e ignora explicaciones basura del modelo
    local comando=$(echo "$cmd_crudo" | grep -a -v '```' | grep -a -v '^#' | sed 's/^`//; s/`$//' | sed '/^$/d' | head -n 1)
    
    echo -e "\e[1;36m🤖 Qwen está resumiendo su utilidad...\e[0m"
    local desc_crudo=$(sgpt --role "Shell Command Descriptor" "$comando")
    local comentario=$(echo "$desc_crudo" | tr '\n' ' ' | tr '\r' ' ' | sed 's/^[ \t]*//')
    
    # Inyecta en la línea de escritura la explicación (comentada) para aprender y el comando para usar
    print -z "${comentario}
${comando}" 
}

# Alias principales (Con 'noglob' le evitamos a Zsh interpretar símbolos de interrogación como rutas)
alias cons="noglob _cons_fn" # [Consulta Rápida] Dispara, responde y limpia su propia memoria.
alias ia="noglob _ia_fn"     # [Chat Infinito] Crea ambiente continuo reteniendo el texto anterior.
alias cmd="noglob _cmd_fn"   # [Comandos GNU] Dedicado a tareas puras usando diccionario comentado.
alias cod="noglob _cod_fn"   # [Programación] Genera solo pedazos de código de lenguajes limpios.
