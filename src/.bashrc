VENV_WRAPPER=/usr/local/bin/virtualenvwrapper.sh 
if [ -f $VENV_WRAPPER ]; then
  export WORKON_HOME=$HOME/.venvs
  export PROJECT_HOME=$HOME/proj
  source $VENV_WRAPPER
fi

