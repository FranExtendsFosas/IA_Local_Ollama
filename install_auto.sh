#!/bin/bash
# 🚀 Instalador Automático de IA Local y Entorno Zsh
# Este script está preparado para ser ejecutado por un Agente IA o un Usuario para desplegar todo el entorno de forma automática.

echo "=========================================================="
echo "🤖 Iniciando Instalación de Entorno Terminal IA (Linux)"
echo "=========================================================="

# 1. Instalar dependencias base
echo "📦 Instalando Zsh, Ollama y dependencias..."
sudo zypper in -y zsh jq curl python3-pipx git

# 2. Instalar y configurar Ollama
echo "🧠 Configurando servicio Ollama..."
curl -fsSL https://ollama.com/install.sh | sh
echo "⬇️ Descargando modelo llama3.2 (Puede tardar varios minutos dependiendo de la conexión)..."
ollama pull llama3.2

# 3. Instalar ShellGPT
echo "🐚 Instalando ShellGPT..."
pipx install shell-gpt

# 4. Forzar creación de configs de SGPT y aplicar las nuestras
echo "⚙️ Configurando ShellGPT local..."
~/.local/bin/sgpt "init" &> /dev/null || true

# Copiamos la configuración y los roles locales
cp -r config_shell_gpt/.sgptrc ~/.config/shell_gpt/
cp -r config_shell_gpt/roles ~/.config/shell_gpt/

# 5. Instalar Oh-My-Zsh y Plugins visuales
echo "🎨 Configurando Entorno Zsh Visual..."
# Install oh-my-zsh unattended
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 6. Replicar Configuración personal (Zshrc y P10k)
echo "📁 Restaurando copias de seguridad de la Terminal..."
cp zsh_config/zshrc_backup ~/.zshrc
cp zsh_config/p10k_backup.zsh ~/.p10k.zsh

echo "=========================================================="
echo "✅ Instalación Completada con Éxito."
echo "⚠️ NOTA IMPORTANTE: Debes instalar la fuente 'MesloLGS NF' en tu sistema o emulador de terminal para ver los iconos correctamente."
echo "Cierra esta terminal y abre una nueva o ejecuta 'zsh' para ver los cambios."
echo "=========================================================="
