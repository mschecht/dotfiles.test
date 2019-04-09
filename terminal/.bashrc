############################
# MAKE TERMINAL GREAT AGAIN!
############################

#----------------
# Terminal prompt
#----------------

# Variables
export COLOR_A="\[\033[0;31m\]"
export COLOR_B="\[\033[0;33m\]"
export COLOR_C="\[\033[0;32m\]"
export COLOR_d="\[\033[0;34m\]"
export COLOR_DEFAULT="\[\e[0m\]"
export PROMPT_DIRTRIM=8
export TIME="\t"
export USER="\u"
export HOST="\h"
export WD="\w" # working directory

# Prompt layout
export PS1="$COLOR_A[$TIME] $COLOR_B[$USER@$HOST:$COLOR_C$WD$COLOR_B]$ $COLOR_DEFAULT\n"

#-----------------
# LS color options
#-----------------

# Here is a good link to changing colors: https://geoff.greer.fm/lscolors/

OS=$(uname) # Run `uname` command to get current OS

# Run necessary colors setting for IOS or Linux
if [[ "$OS" == "Linux" ]]; then
	export LSCOLORS=di=1;36:ln=1;35:so=1;32:pi=1;33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=34;43 # Linux
elif [[ "$OS" == "Darwin" ]]; then
    export CLICOLOR=2    
	export LSCOLORS=GxFxCxDxBxegedabagaced # IOS
fi


#------------------------------
# BASH command history settings
#------------------------------
# Great resource: https://www.shellhacks.com/tune-command-line-history-bash/

# ignorespace: don’t save lines which begin with a <space> character; erasedups: eliminate duplicates across the whole history
export HISTCONTROL=ignorespace:erasedups
# Increase size
export HISTSIZE=100000000000
export HISTFILESIZE=10000000000
# Append Bash Commands to History File
shopt -s histappend
# History time format
HISTTIMEFORMAT="%d/%m/%y %T "

#after each command save and reload history

log_bash_persistent_history()
{
        [[
        $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$
        ]]
        local date_part="${BASH_REMATCH[1]}"
        local command_part="${BASH_REMATCH[2]}"
        if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
        then
                echo $date_part "|" "$command_part" >> ~/.persistent_history
                export PERSISTENT_HISTORY_LAST="$command_part"
        fi
}

# Stuff to do on PROMPT_COMMAND
run_on_prompt_command()
{
        log_bash_persistent_history
}

export PROMPT_COMMAND="history -a; history -c; history -r; run_on_prompt_command; $PROMPT_COMMAND"

#-------------
# BASH Aliases
#-------------

# All aliases are here
if [ -f ~/.bash-aliases ]; then
   . ~/.bash-aliases
fi

#---------------
# BASH Functions
#---------------

# All BASH functions are here
if [ -f ~/.bash-functions ]; then
. ~/.bash-functions
fi


#----------
# Miniconda
#----------
#export PATH=""${HOME}"/miniconda3/miniconda3/bin:$PATH"
export PATH="$HOME/miniconda3/bin:$PATH"



#----------------------
# Pointing RStudio to R
#----------------------
export RSTUDIO_WHICH_R=/usr/local/Cellar/r/3.5.3/bin/R
