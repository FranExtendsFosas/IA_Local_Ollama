# 🤖 Guía de Instalación: Asistente IA Local (Ollama + ShellGPT + Qwen) en Zsh

Esta guía documenta el proceso definitivo para integrar un modelo de Inteligencia Artificial enfocado en programación (**Qwen 2.5 Coder**) directamente en la terminal de Linux (Zsh). Funciona como un asistente ultra-rápido cien por cien en local, privado, sin alucinaciones, comentando sus propios comandos antes de ejecutarlos.

## 🛠️ Requisitos Previos
* Distribución Linux (Ubuntu, openSUSE, Arch...)
* Tarjeta gráfica dedicada (idealmente Nvidia de 4GB+).
* Zsh instalado y configurado (compatible con Oh-My-Zsh y Powerlevel10k).
* `python3-pipx` o similar para instalar paquetes de Python.

---

## 🚀 Paso 1: Instalación de Ollama y el Modelo Qwen

Ollama ejecuta los modelos de IA localizando aceleración gráfica pura. Llama 3.2 era conversacional, pero **Qwen 2.5 Coder de 3B** es un ingeniero de Linux y no inventa banderas (flags) inexistentes.

1. **Instalar Ollama:**
   ```bash
   curl -fsSL https://ollama.com/install.sh | sh
   ```

2. **Descargar el modelo de programación avanzado (Ocupa ~1.9 GB):**
   ```bash
   ollama pull qwen2.5-coder:3b
   ```

---

## 📦 Paso 2: Instalar y Configurar ShellGPT (sgpt)

ShellGPT es el intermediario en Python que conecta la API de Ollama con nuestras funciones de Zsh.

1. **Instalación:**
   ```bash
   sudo zypper in python3-pipx
   pipx install shell-gpt
   ```

2. **Generar archivos iniciales (te pedirá API key, pon cualquier cosa):**
   ```bash
   sgpt "hola"
   ```

---

## ⚙️ Paso 3: Volcado de Configuración y Roles

Para que el modelo se comporte de forma estricta (no envuelva los comandos en Markdown y sea hiper reduccionista dictando parámetros), debes reemplazar dos cosas en tu máquina con los archivos de esta carpeta:

1. **Configuración Base `.sgptrc`**:
   Sustituye el contenido de tu `~/.config/shell_gpt/.sgptrc` con el archivo proporcionado `config_shell_gpt/.sgptrc`. Se asegura de apuntar a `localhost:11434` y exige que el `DEFAULT_MODEL` sea `qwen2.5-coder:3b`.
   
2. **Los Roles de Personalidad**:
   Copia los archivos dentro de `config_shell_gpt/roles/` hacia `~/.config/shell_gpt/roles/`. Esto incluye:
   * **Shell Command Generator:** Obligado a dar comandos limpios 100% compatibles con openSUSE sin adornos.
   * **Shell Command Descriptor:** Obligado a explicar el código de forma ultracorta y sintética para usarlo de comentario superior.

---

## ⌨️ Paso 4: Zsh Aliases de la IA (Las 4 Claves de Poder)

La integración estrella se pega directamente en tu `~/.zshrc`. Tienes el código base para copiártelo dentro del archivo `zsh_aliases.sh`.

Al hacerlo o recargar tu terminal (`source ~/.zshrc`), dispondrás de estos cuatro métodos milagrosos gestionados de firma limpia con `noglob`:

| Qué escribes en consola | Objetivo del Asistente | ¿Cómo opera? |
| :--- | :--- | :--- |
| **`cons [pregunta]`** | **Conocimiento rápido** | Respuesta directa que se autodestruye. (Ej: `cons año de creación linux`). |
| **`ia`** o **`ia [hola]`** | **Chat Inmersivo (REPL)** | Abre una sesión interactiva (ChatGPT) **con memoria** del contexto anterior. Escribe `exit` para salir. |
| **`cmd [tarea a hacer]`** | **Ingeniero de Sistema** | Extrae de Qwen el código. Extrae la explicación. Las unifica y las inserta (con un # en la explicación como salto de línea) mágicamente en tu teclado sin dar un Intro. |
| **`cod [programa x]`** | **Programación Pura** | Escupe el snippet o bloque de código directamente. Ideal para redireccionar a archivos de desarrollo. |

---

## 🎨 Paso 5: Replicación Visual (Zsh + Powerlevel10k)

La estética completa que utilizamos se basa en una `.zshrc` increíblemente pulida (y sin líneas comentadas redundantes), además de los plugins clave.

1. Instalar la fuente **MesloLGS NF** en tu sistema operativo y aplicarla a la emulación de tu terminal actual (Konsole, Gnome Terminal, etc).
2. Clonar los plugins:
   ```bash
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   ```
3. Sustituir en tu otro ordenador el `~/.zshrc` y `~/.p10k.zsh` por los que respaldamos oficialment en la carpeta de este git `zsh_config/`.

---
## 💡 Ejemplo Demostrativo (`cmd`)

Si tecleas `cmd listar los programas con zypper`, sin llegar a presionar Enter, aparecerá de golpe esto parpadeando en tu cuadro de texto:

```bash
# zypper se -i: busca y lista detalles de paquetes instalados.
zypper se -i
```
Podrás leerlo, entender sus comandos y presionar **Enter** con confianza. ¡La experiencia local perfecta!
