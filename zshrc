alias ls="ls -G"
alias grep="grep --color=auto"

autoload -U colors && colors

if hostname | grep -qE '^sh'; then
   PROMPT="%{$fg[red]%}%1~ %#%{$reset_color%} "
fi

if [[ $(uname -s) = Darwin ]]; then
    alias Finder="open -a Finder.app"
    alias Emacs="open -a Emacs"
    if hostname | grep -qE '^sh'; then
        alias Firefox="open -a '/Applications/Firefox Nightly.app'"
    else
        alias Firefox="open -a '/Applications/Firefox.app'"
    fi
fi

# Haskell / ghcup
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
