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

if [[ $(uname -s) = Darwin ]]; then
    alias Finder="open -a Finder.app"
    alias Emacs="open -a Emacs"
    if hostname | grep -qE '^sh'; then
        alias Firefox="open -a '/Applications/Firefox Nightly.app'"
    else
        alias Firefox="open -a '/Applications/Firefox.app'"
    fi
    alias brew="$HOME/homebrew/bin/brew"
    alias stree="/Applications/SourceTree.app/Contents/Resources/stree"
fi

# Haskell / ghcup
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
