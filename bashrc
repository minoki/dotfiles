# -*- mode: shell-script -*-
alias grep="grep --color=auto"

# macOS
if [[ $(uname -s) = Darwin ]]; then
    alias ls="ls -G"
    alias Finder="open -a Finder.app"
    alias TextEdit="open -a TextEdit.app"
    alias Firefox="open -a /Applications/Firefox.app"
    alias Emacs="open -a Emacs"
    alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'
    alias brew="$HOME/homebrew/bin/brew"
    alias stree="/Applications/SourceTree.app/Contents/Resources/stree"
else
    alias ls="ls --color=auto"
fi

# MSYS2/Windows
if uname -s | grep -qE '^(MSYS|MINGW)'; then
    LOCALAPPDATA_UNIX="$(cygpath --unix "$LOCALAPPDATA")"
    APPDATA_UNIX="$(cygpath --unix "$APPDATA")"
    cmd.exe //C "chcp 65001 > NUL"

    # TeX Live 2018
    export PATH="/c/texlive/2018/bin/win32:$PATH"

    # Visual Studio Code
    alias code="\"$LOCALAPPDATA_UNIX/Programs/Microsoft VS Code/bin/code\""

    # Julia
    alias julia="$LOCALAPPDATA_UNIX/Programs/Julia/Julia-1.4.2/bin/julia.exe"

    # dotnet
    alias dotnet="\"/c/Program Files/dotnet/dotnet.exe\""

    # Go
    export GOROOT=C:\\Go\\
    export PATH="/c/Go/bin/:$PATH"

    # Rust
    export PATH="$(cygpath --unix "$USERPROFILE")/.cargo/bin:$PATH"

    # Docker
    export PATH="/c/ProgramData/DockerDesktop/version-bin:/c/Program Files/Docker/Docker/Resources/bin:$PATH"

    # Haskell stack
    export PATH="$APPDATA_UNIX/local/bin/:$PATH"
    function stack32() {
	env PATH="$HOME/.local32/bin:$PATH" STACK_ROOT="C:\\sr32" $HOME/.local32/bin/stack "$@"
    }

    # Intel SDE
    alias sde=$HOME/sde-external-8.56.0-2020-07-05-win/sde.exe
    function set-sde() {
	export PATH="$HOME/sde-external-8.56.0-2020-07-05-win/:$PATH"
    }

    # Visual Studio
    function vcvars64-vs2017.bat() {
	echo "Using vcvars64.bat from VS2017..."
	source <(cmd //c "(" "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat" "&&" "C:\msys64\usr\bin\env" ")" | grep -P '^(?!PWD=)(?!(MAN|INFO|PKG_CONFIG_)PATH=)\w+=' | sed -e "s/[\\|&;()<> \t]/\\\&/g" | sed -re "s/^(.+)$/export \1/g")
    }
    function vcvars32-vs2017.bat() {
	echo "Using vcvars32.bat from VS2017..."
	source <(cmd //c "(" "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars32.bat" "&&" "C:\msys64\usr\bin\env" ")" | grep -P '^(?!PWD=)(?!(MAN|INFO|PKG_CONFIG_)PATH=)\w+=' | sed -e "s/[\\|&;()<> \t]/\\\&/g" | sed -re "s/^(.+)$/export \1/g")
    }
    function vcvars64-vs2019.bat() {
	echo "Using vcvars64.bat from VS2019..."
	source <(cmd //c "(" "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat" "&&" "C:\msys64\usr\bin\env" ")" | grep -P '^(?!PWD=)(?!(MAN|INFO|PKG_CONFIG_)PATH=)\w+=' | sed -e "s/[\\|&;()<> \t]/\\\&/g" | sed -re "s/^(.+)$/export \1/g")
    }
    function vcvars32-vs2019.bat() {
	echo "Using vcvars32.bat from VS2019..."
	source <(cmd //c "(" "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars32.bat" "&&" "C:\msys64\usr\bin\env" ")" | grep -P '^(?!PWD=)(?!(MAN|INFO|PKG_CONFIG_)PATH=)\w+=' | sed -e "s/[\\|&;()<> \t]/\\\&/g" | sed -re "s/^(.+)$/export \1/g")
    }
    function vcvars-arm64-vs2019.bat() {
	echo "Using vcvarsamd64_arm64.bat from VS2019..."
	source <(cmd //c "(" "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsamd64_arm64.bat" "&&" "C:\msys64\usr\bin\env" ")" | grep -P '^(?!PWD=)(?!(MAN|INFO|PKG_CONFIG_)PATH=)\w+=' | sed -e "s/[\\|&;()<> \t]/\\\&/g" | sed -re "s/^(.+)$/export \1/g")
    }
    alias vcvars64.bat=vcvars64-vs2019.bat
    alias vcvars32.bat=vcvars32-vs2019.bat

    # Java
    #   Taken from https://stackoverflow.com/a/44602323:
    #   JAVA_HOME=$(powershell '$p="HKLM:\SOFTWARE\JavaSoft\JDK"; $v=(gp $p).CurrentVersion; (gp $p/$v).JavaHome');
    JAVA_HOME=$( p="/HKLM/SOFTWARE/JavaSoft/JDK"; v=$(regtool get "$p/CurrentVersion"); regtool get "$p/$v/JavaHome" )
    JAVA_HOME_UNIX=$(cygpath -u "$JAVA_HOME")
    export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
    function java() {
	env JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS/-Dfile.encoding=UTF-8/}" "$JAVA_HOME_UNIX/bin/java.exe" -Dfile.encoding=UTF-8 "$@"
    }
    function javac() {
	env JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS/-Dfile.encoding=UTF-8/}" "$JAVA_HOME_UNIX/bin/javac.exe" -J-Dfile.encoding=UTF-8 "$@"
    }
    function set-java-path() {
	export PATH="$JAVA_HOME_UNIX/bin:$PATH"
    }
    # With JScript:
    #   var WshShell = new ActiveXObject("WScript.Shell");
    #   var p = "HKLM\\SOFTWARE\\JavaSoft\\JDK\\";
    #   var CurrentVersion = WshShell.RegRead(p + "CurrentVersion");
    #   var JavaHome = WshShell.RegRead(p + CurrentVersion + "\\JavaHome");
    #   WScript.Echo(JavaHome);
    # With regtool:
    #   function get-java-home() {
    #       local p="/HKLM/SOFTWARE/JavaSoft/JDK"
    #       local CurrentVersion=$(regtool get "$p/CurrentVersion")
    #       regtool get "$p/$CurrentVersion/JavaHome"
    #   }

    function set-cuda-v11.0() {
	export CUDA_PATH="$CUDA_PATH_V11_0"
	export PATH="/c/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.0/bin:$PATH"
    }
    function set-cuda-v11.1() {
	export CUDA_PATH="$CUDA_PATH_V11_1"
	export PATH="/c/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.1/bin:$PATH"
    }
fi

# 31: red, 1: bold, 4: underline
# PS1="\[\033[31;1;4m\]\h:\W \u\$\[\033[0m\] "
if hostname | grep -qE '^su'; then
    # 34: blue
    PS1='\[\033[34;1;4m\]\W \$\[\033[0m\] '
fi

# MacPorts
if [ -d /opt/local/bin ]; then
    export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
    export MANPATH="/opt/local/share/man:$MANPATH"

    if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
	. /opt/local/etc/profile.d/bash_completion.sh
    fi
fi

# TeX Live 2020
if [ -d /usr/local/texlive/2020 ]; then
    export MANPATH="/usr/local/texlive/2020/texmf-dist/doc/man:$MANPATH"
    export INFOPATH="/usr/local/texlive/2020/texmf-dist/doc/info:$INFOPATH"
    if [[ "$(uname -s)" = Darwin ]]; then
	export PATH="/usr/local/texlive/2020/bin/x86_64-darwin/:$PATH"
    fi
fi

# Standard ML / OCaml
if [ -f "$HOME/.opam/opam-init/init.sh" ]; then
    source "$HOME/.opam/opam-init/init.sh"
fi
if [ -d /opt/mlton/bin ]; then
    export PATH="/opt/mlton/bin:$PATH"
fi
( which rlwrap sml > /dev/null 2>&1 ) && alias sml="rlwrap sml"
( which rlwrap smlsharp > /dev/null 2>&1 ) && alias smlsharp="rlwrap smlsharp"
( which rlwrap ocaml > /dev/null 2>&1 ) && alias ocaml="rlwrap ocaml"

# Rust
if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Haskell (ghcup)
if [ -f "$HOME/.ghcup/env" ]; then
    source "$HOME/.ghcup/env"
fi

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -f "$HOME/.bashrc_local" ]; then
    source "$HOME/.bashrc_local"
fi
. "$HOME/.cargo/env"
