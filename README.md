# 🤖 Guía de Instalación: Asistente IA Local (Ollama + ShellGPT) en Linux (Zsh)

Esta guía documenta todo el proceso que seguimos para integrar un modelo de Inteligencia Artificial (Llama 3.2) directamente en la terminal de Linux (zsh) para que funcione como un asistente personal rápido, similar a la experiencia "Warp Console", pero 100% en local y privado.

## 🛠️ Requisitos Previos
* Cualquier distribución Linux (Ubuntu, Debian, openSUSE, Arch...)
* Tarjeta gráfica dedicada (idealmente Nvidia 4GB+ para que quepan modelos eficientes como Llama 3.2 de 3B).
* Zsh instalado y configurado (compatible con Oh-My-Zsh y Powerlevel10k).
* `python3-pipx` o entorno virtual parecido para instalar paquetes de Python.

---

## 🚀 Paso 1: Instalación de Ollama y el Modelo IA

Ollama es el motor en segundo plano (Daemon) que ejecuta el cerebro de la IA.

1. **Instalar Ollama oficialmente:**
   ```bash
   curl -fsSL https://ollama.com/install.sh | sh
   ```
   *Nota: Detectará automáticamente si tienes Nvidia y configurará aceleración por hardware (CUDA).*

2. **Descargar el modelo ligero para terminal (`llama3.2`):**
   *(Este modelo de 3B ocupa ~2.0 GB de VRAM, dejando memoria libre para otras tareas y proveyendo un razonamiento excelente).*
   ```bash
   ollama pull llama3.2
   ```

---

## 📦 Paso 2: Instalar ShellGPT (sgpt)

ShellGPT es un programa en Python muy robusto e integrado para lanzar _prompts_ al modelo directamente. Usarlo evita problemas graves que suceden si programamos _scripts_ manuales en Zsh (como atascos con la visualización por el agresivo diseño del tema Powerlevel10k).

1. **Instalar dependencias y ShellGPT:**
   ```bash
   sudo zypper in python3-pipx
   pipx install shell-gpt
   ```

2. **Generar el archivo de configuración inicial:**
   Ejecuta esto en una terminal, y cuando te pida una "API KEY", escribe cualquier letra y pulsa `Enter`. Esto forzará un error inicial pero creará la carpeta `~/.config/shell_gpt`.
   ```bash
   sgpt "hola"
   ```

---

## ⚙️ Paso 3: Configurar ShellGPT para Ollama Local

Por defecto, ShellGPT intenta conectarse a los servidores de la nube de ChatGPT. Hay que desviar su atención a tu computadora local.

1. Reemplazamos el archivo `~/.config/shell_gpt/.sgptrc` (puedes usar el archivo `config_shell_gpt/.sgptrc` incluido en esta carpeta) para que contenga **exactamente** estas tres líneas clave en lugar del acceso por defecto:

   ```env
   OPENAI_API_HOST=http://localhost:11434/v1
   OPENAI_API_KEY=ollama
   DEFAULT_MODEL=llama3.2
   ```

---

## 🧠 Paso 4: Evitar las "Alucinaciones" (Roles en Español)

Para que el modelo Llama 3.2 conteste en español perfecto, explique los comandos como un profesor paciente y no intente "buscar con código dentro de Linux" si le preguntas por la capital de Francia, modificamos sus **Roles Internos**.

*   Solo tienes que copiar la carpeta `roles/` que está incluida aquí junto a esta guía y sustituirla por la que el programa generó en `~/.config/shell_gpt/roles/`.

---

## ⌨️ Paso 5: Los Alias y La Magia en la Terminal (Zsh)

Por último, para hacer la comunicación 100% natural, eliminamos la necesidad de poner comillas `""` o de usar la palabra completa `sgpt` al comienzo de cada instrucción.

Copia las líneas del documento `zsh_aliases.sh` (puedes revisarlo en esta carpeta) y transfiérelas a tu archivo real **`~/.zshrc`**.

**¿Qué milagros técnicos hace ese código en Zsh?**
* **Funciones que juntan palabras:** Engloban cada palabra que escribes sin comillas para que a `sgpt` le llegue como "una sola orden".
* **El comando protector `noglob`:** Evita que Zsh malinterprete signos como la interrogación (`?` = error bash de _string match failed_).
* **El atajo de Teclado `Ctrl + G`:** Llama a la macro oculta de `sgpt --shell --no-interaction`, evalúa lo escrito, y te entrega el comando crudo para dispararlo directamente sin tener que darle a Enter primero.

---

## � Paso 6: Replicación Visual de la Terminal (Zsh + Powerlevel10k)

Para que la terminal en el otro ordenador luzca y funcione exactamente igual que esta (con autocompletado, resaltado de sintaxis, iconos y el tema Powerlevel10k), hemos copiado tus configuraciones clave en la carpeta `zsh_config`. Para replicarlo en otro equipo, sigue estos pasos:

1. **Instalar Zsh y Oh-My-Zsh:**
   En el nuevo ordenador, instala Zsh y el framework Oh-My-Zsh primero.
   ```bash
   sudo zypper in zsh
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

2. **Instalar la Fuente (Fonts) necesaria:**
   Powerlevel10k requiere la fuente **Meslo Nerd Font** para mostrar los iconos correctamente. Debes descargarla e instalarla en tu sistema o configurar tu emulador de terminal (Konsole, GNOME Terminal, etc.) para usarla.
   * [Descargar recomendada: MesloLGS NF](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)

3. **Instalar el Tema Powerlevel10k y los Plugins:**
   Descarga el tema P10k y los plugins de sintaxis y sugerencias en las carpetas custom de Oh-My-Zsh.
   ```bash
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   ```

4. **Copiar tus configuraciones de respaldo:**
   Sustituye los archivos por defecto del nuevo equipo por nuestras copias documentadas aquí:
   ```bash
   cp IA_Local_Ollama/zsh_config/zshrc_backup ~/.zshrc
   cp IA_Local_Ollama/zsh_config/p10k_backup.zsh ~/.p10k.zsh
   ```

5. **Aplica y comprueba:**
   Recarga la terminal con `source ~/.zshrc` y todo el aspecto visual y los plugins cobrarán vida al instante, exactamente igual que en tu sistema original.

---
## �🎉 Diccionario de Uso Rápido (Una vez instalado)

| Lo que escribes en la consola | Lo que hace internamente |
| :--- | :--- |
| `ia cómo abro puertos en apache?` | Responde con inteligencia y explicaciones generales |
| `cmd listar ocultos en media` | Responde con Asistente (Opción **E**jecutar, **D**escribir, **A**bortar) |
| `cod crear clase python persona` | Genera **únicamente el código** de programación listo para guardar/copiar |
| `chat enseñame comandos basicos de git` | Empieza un **Modo Conversación Infinita** con memoria |
| (Escribes) `borrar la papelera` + **Ctrl+G** | Sustituye tu texto escrito al instante por el comando crudo, ej: `rm -rf ~/.local/share/Trash/files/*` |
