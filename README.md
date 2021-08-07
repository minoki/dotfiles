# Install

```
$ git clone https://github.com/minoki/dotfiles.git
$ DOTFILES="`pwd`/dotfiles"
$ ln -s $DOTFILES/gitconfig .gitconfig
$ mkdir -p .emacs.d && ln -s $DOTFILES/emacs-init.el .emacs.d/init.el
$ ln -s $DOTFILES/bashrc .bashrc
$ ln -s $DOTFILES/zshrc .zshrc
```

```
$ echo 'VisualHostKey yes' >> .ssh/config
```

[Homebrew](https://docs.brew.sh/Installation)

```
mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
```

```
mkdir -p .zsh/completion
cd .zsh/completion
ln -s /opt/local/share/git/contrib/completion/git-completion.zsh _git
```
