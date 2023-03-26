# -*- mode: shell-script -*-
alias ls="ls -G"
alias grep="grep --color=auto"

fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit -u

autoload -U colors && colors

if hostname | grep -qE '^sh'; then
   PROMPT="%{$fg[red]%}%1~ %#%{$reset_color%} "
fi
if hostname | grep -qE '^ak'; then
   PROMPT="%{$fg[blue]%}%1~ %#%{$reset_color%} "
fi

setopt no_auto_remove_slash

if [[ $(uname -s) = Darwin ]]; then
    alias Finder="open -a Finder.app"
    alias Emacs="open -a Emacs"
    alias Firefox="open -a '/Applications/Firefox.app'"
    if hostname | grep -qE '^sh'; then
        HOMEBREW_PREFIX=/opt/homebrew
    else
        HOMEBREW_PREFIX="$HOME/homebrew"
    fi
    alias stree="/Applications/SourceTree.app/Contents/Resources/stree"
    alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'
    export PATH="/opt/local/bin:$HOMEBREW_PREFIX/bin:$PATH"
    export HOMEBREW_EDITOR=emacs
    export INFOPATH="/opt/local/share/info:$INFOPATH"
fi

# TeX Live
if [ -d /usr/local/texlive/2023 ]; then
    export MANPATH="/usr/local/texlive/2023/texmf-dist/doc/man:$MANPATH"
    export INFOPATH="/usr/local/texlive/2023/texmf-dist/doc/info:$INFOPATH"
    if [[ "$(uname -s)" = Darwin ]]; then
        export PATH="/usr/local/texlive/2023/bin/universal-darwin:$PATH"
    fi
else
    if [ -d /usr/local/texlive/2022 ]; then
        export MANPATH="/usr/local/texlive/2022/texmf-dist/doc/man:$MANPATH"
        export INFOPATH="/usr/local/texlive/2022/texmf-dist/doc/info:$INFOPATH"
        if [[ "$(uname -s)" = Darwin ]]; then
            export PATH="/usr/local/texlive/2022/bin/universal-darwin:$PATH"
        fi
    else
        if [ -d /usr/local/texlive/2021 ]; then
            export MANPATH="/usr/local/texlive/2021/texmf-dist/doc/man:$MANPATH"
            export INFOPATH="/usr/local/texlive/2021/texmf-dist/doc/info:$INFOPATH"
            if [[ "$(uname -s)" = Darwin ]]; then
                export PATH="/usr/local/texlive/2021/bin/universal-darwin:$PATH"
            fi
        fi
    fi
fi

# Haskell / ghcup
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

test -r "$HOME/.opam/opam-init/init.zsh" && . "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null || true

( which rlwrap sml > /dev/null 2>&1 ) && alias sml="rlwrap sml"
( which rlwrap smlsharp > /dev/null 2>&1 ) && alias smlsharp="rlwrap smlsharp"
( which rlwrap ocaml > /dev/null 2>&1 ) && alias ocaml="rlwrap ocaml"
( which rlwrap luajit > /dev/null 2>&1 ) && alias luajit="rlwrap luajit"

if [ -d /opt/mlton/bin ]; then
    export PATH=/opt/mlton/bin:$PATH
fi

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
