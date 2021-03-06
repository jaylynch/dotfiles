if [ -f ~/ORIG.bashrc ]; then
  . ~/ORIG.bashrc
fi

VENV_WRAPPER=/usr/local/bin/virtualenvwrapper.sh

# If running in Windows git bash
if [ "$(uname -s | cut -c 1-10)" '==' "MINGW32_NT" ]; then
  VENV_WRAPPER=/c/Python/Scripts/virtualenvwrapper.sh
fi

if [ -n "$ZSH_VERSION" ]; then
  autoload -U compinit
  compinit 2>&1 > /dev/null
  autoload -U bashcompinit
  bashcompinit 2>&1 > /dev/null
fi

if [ -f $VENV_WRAPPER ]; then
  export WORKON_HOME=$HOME/.venvs
  export PROJECT_HOME=$HOME/proj
  export VIRTUALENVWRAPPER_HOOK_DIR=$HOME/.venv_hooks
  source $VENV_WRAPPER

  alias wo='workon'
  complete -o default -o nospace -F _virtualenvs wo

  # Automatically load if ".venv" file found
  # With thanks to: https://justin.abrah.ms/dotfiles/zsh.html#sec-2-7
  # Support for bash
  PROMPT_COMMAND='prompt'

  # Mirrored support for zsh. See: https://superuser.com/questions/735660/whats-the-zsh-equivalent-of-bashs-prompt-command/735969#735969
  precmd()
  {
    eval "$PROMPT_COMMAND"
  }

  function prompt()
  {
    if [ "$PWD" '==' "$HOME" ]; then
      unset MYOLDPWD
      if [ "$(declare -f deactivate > /dev/null; echo $?)" '==' 0 ]; then
        deactivate
      fi
    fi

    if [ "$PWD" '!=' "$MYOLDPWD" ]; then
      MYOLDPWD="$PWD"
      test -e .venv && workon `cat .venv`
    fi
  }
fi

if [ -n "$BASH_VERSION" ]; then
  source ~/.bash/git-completion.bash

  export HISTCONTROL=erasedups
  export HISTFILE=~/.bash_eternal_history
  export HISTFILESIZE=
  export HISTSIZE=
  export HISTTIMEFORMAT="[%F %T] "

  PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
fi

if command -v nvm 2>&1 >/dev/null; then
  function check_nvm()
  {
    if [ -f .nvmrc ]; then
      USING_NODE_VERSION=$(nvm version)
      DIR_NODE_VERSION=$(nvm version `cat .nvmrc`)
      if [ "${USING_NODE_VERSION}" != "${DIR_NODE_VERSION}" ]; then
        nvm use
      fi
    fi
  }

  PROMPT_COMMAND="check_nvm; $PROMPT_COMMAND"
fi

function srv()
{
  DIRNAME=${PWD##*/}
  DJANGO_SCRIPT="manage.py"

  if [ -f "${DIRNAME}/$DJANGO_SCRIPT" ]; then
    COMMAND="python ${DIRNAME}/${DJANGO_SCRIPT} runserver 0.0.0.0:8000"
  elif [ -f "django/$DJANGO_SCRIPT" ]; then
    COMMAND="python django/${DJANGO_SCRIPT} runserver 0.0.0.0:8000"
  elif [ -f $DJANGO_SCRIPT ]; then
    COMMAND="python ${DJANGO_SCRIPT} runserver 0.0.0.0:8000"
  else
    COMMAND="python -m SimpleHTTPServer"
  fi

  eval $COMMAND
}

# Aliases
alias bcomp='bcompare'
alias shipit='git push --tags origin master && git push --tags prod master'
alias stageit='git push --tags origin dev && git push --tags staging dev'

# enable color support of ls and also add handy aliases
# (Thanks Ubuntu!)
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias ll='ls -alFh'

# Load rbenv if found
if [ -f $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
fi

if command -v brew 2>&1 >/dev/null; then
  # Load NVM if possible
  export NVM_DIR=~/.nvm
  . $(brew --prefix nvm)/nvm.sh

  # Add Homebrew Go install to PATH
  export PATH=$PATH:/usr/local/opt/go/libexec/bin


  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

if command -v go 2>&1 >/dev/null; then
  export GOPATH=$HOME/proj/go
  export PATH=$PATH:$(go env GOPATH)/bin
fi

if command -v yarn 2>&1 >/dev/null; then
  export PATH=$PATH:$(yarn global bin)
fi

if [ -d $HOME/.yarn ]; then
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

# added by travis gem
[ -f /Users/jay/.travis/travis.sh ] && source /Users/jay/.travis/travis.sh

