VENV_WRAPPER=/usr/local/bin/virtualenvwrapper.sh 

# If running in Windows git bash
if [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  VENV_WRAPPER=/c/Python/Scripts/virtualenvwrapper.sh
fi

source ~/.bash/git-completion.bash

if [ -f $VENV_WRAPPER ]; then
  export WORKON_HOME=$HOME/.venvs
  export PROJECT_HOME=$HOME/proj
  export VIRTUALENVWRAPPER_HOOK_DIR=$HOME/.venv_hooks
  source $VENV_WRAPPER

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
    if [ "$PWD" == "$HOME" ]; then
      unset MYOLDPWD
      if [ -n "$(type -t deactivate)" ] && [ "$(type -t deactivate)" = function ]; then
        deactivate
      fi
    fi

    if [ "$PWD" != "$MYOLDPWD" ]; then
      MYOLDPWD="$PWD"
      test -e .venv && workon `cat .venv`
    fi
  }

fi

