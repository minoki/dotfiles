# -*- mode: shell-script -*-
alias ls="ls -G"
alias grep="grep --color=auto"

fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit -u

local ssh_config_hosts
ssh_config_hosts=(${${${(M)${(f)"$(cat ~/.ssh/config(N) ~/.ssh/conf.d/*(N) 2>/dev/null)"}:#Host *}#Host }:#*[*?]*})
zstyle ':completion:*:(ssh|scp|sftp|rsync):*' hosts $ssh_config_hosts

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
    if [[ $(uname -m) = arm64 ]]; then
        HOMEBREW_PREFIX=/opt/homebrew
    else
        HOMEBREW_PREFIX="$HOME/homebrew"
    fi
    alias stree="/Applications/SourceTree.app/Contents/Resources/stree"
    alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'
    export PATH="/opt/local/bin:$HOMEBREW_PREFIX/bin:$PATH"
    export HOMEBREW_EDITOR=emacs
    export INFOPATH="/opt/local/share/info:$INFOPATH"
    if [ -x "/opt/local/lib/ImageMagick7/bin/magick" ]; then
        alias magick="/opt/local/lib/ImageMagick7/bin/magick"
    fi
fi

# TeX Live
for year in 2026 2025 2024 2023 2022 2021; do
    prefix="/usr/local/texlive/$year"
    if [ -d "$prefix" ]; then
        export MANPATH="$prefix/texmf-dist/doc/man:$MANPATH"
        export INFOPATH="$prefix/texmf-dist/doc/info:$INFOPATH"
        if [[ "$(uname -s)" = Darwin ]]; then
            export PATH="$prefix/bin/universal-darwin:$PATH"
        fi
        break
    fi
done

# Haskell / ghcup
if [ -f "$HOME/.ghcup/env" ]; then
    source "$HOME/.ghcup/env"
elif hostname | grep -qE '^sh'; then
    export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
elif hostname | grep -qE '^Ma'; then
    export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
fi

test -r "$HOME/.opam/opam-init/init.zsh" && . "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null || true

if [ -d /opt/mlton/bin ]; then
    export PATH=/opt/mlton/bin:$PATH
fi

if [ -d /opt/smlsharp/bin ]; then
    export PATH=/opt/smlsharp/bin:$PATH
fi

( which rlwrap sml > /dev/null 2>&1 ) && alias sml="rlwrap sml"
( which rlwrap smlsharp > /dev/null 2>&1 ) && alias smlsharp="rlwrap smlsharp"
( which rlwrap ocaml > /dev/null 2>&1 ) && alias ocaml="rlwrap ocaml"
( which rlwrap luajit > /dev/null 2>&1 ) && alias luajit="rlwrap luajit"

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
