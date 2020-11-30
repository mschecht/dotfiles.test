# bibtex script
# Make .bib file in current directory and add bibtex citations to it with DOI
# usage: doi2bib DOI
doi2bib ()
{
	printf "\n">> $2
	curl -s "http://api.crossref.org/works/$1/transform/application/x-bibtex" >> $2;
}

# create .tar.gz
targz() { tar -zcvf $1.tar.gz $1; rm -r $1; }

#tmuxnew() { tmux new-session -s $1 bash; }

# extract *ANY* compressed file
extract ()
{
      if [ -f $1 ] ; then
        case $1 in
          *.tar.bz2)   tar xjf $1     ;;
          *.tar.gz)    tar xzf $1     ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar e $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xf $1      ;;
          *.tbz2)      tar xjf $1     ;;
          *.tgz)       tar xzf $1     ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)     echo "'$1' cannot be extracted via extract()" ;;
           esac
       else
           echo "'$1' is not a valid file"
       fi
}

# What's the weather?
weather() { curl wttr.in/"$1"; }

# Automagically open Jupyter Lab and have it connected to server
# credit: https://benjlindsay.com/blog/running-jupyter-lab-remotely/
function jllocal {
	cmd="ssh -Y -fN -L localhost:8888:localhost:8888 mschecht@bigmem-3"
	running_cmds=$(ps aux | grep -v grep | grep "$cmd")
	if [[ "$1" == 'kill' ]]; then
		if [ ! -z $running_cmds ]; then
			for pid in $(echo $running_cmds | awk '{print $2}'); do
				echo "killing pid $pid"
				kill -9 $pid
				done
		else
			echo "No jllocal commands to kill."
		fi
	else
		if [ ! -z $n_running_cmds ]; then
			echo "jllocal command is still running. Kill with 'jllocal kill' next time."
		else
			echo "Running command '$cmd'"
			eval "$cmd"
		fi
    
	url=$(ssh mschecht@bigmem-3:/scratch/mschecht/post_msc | grep http | awk '{print $1}')
    echo "URL that will open in your browser:"
    echo "$url"
    open "$url"
  fi
}
# Automgaically open A'nvio and have it connected to server
# DO IT Yourself
# credit: http://merenlab.org/2015/11/28/visualizing-from-a-server/
#

# Zcat + head 
zhead() {
  head <(zcat $1)
}


# tmux function

tmux-dev () {
	tmux new-session bash
	tmux split-window -v 'ipython'
	tmux split-window -h
	tmux new-window 'mutt'
	tmux -2 attach-session -d
}

# anvio stuffs, inspired by here: http://merenlab.org/2016/06/26/installation-v2/#following-the-active-codebase-youre-a-wizard-arry
deactivate_smart () {
	echo "Deactivating"
	{
		deactivate && conda deactivate
	} &> /dev/null
}

init_anvio_stable () {
	{
		deactivate && conda deactivate
	} &> /dev/null
	export PATH="/Users/$USER/miniconda3/bin:$PATH"
	conda activate anvio-6.2
	echo "anvi'o 6.2 is now active. If you need master, please run anvi-activate-master."
	PS1="(\$CONDA_DEFAULT_ENV) $YELLOW[$USER@$HOSTSTYLE\h$YELLOW:$RED$WD$YELLOW]$RED \$git_branch 🌴 $COLOR_DEFAULT"
}

init_anvio_master () {
	{
		deactivate && conda deactivate
	} &> /dev/null
	export PATH="/Users/$USER/miniconda3/bin:$PATH"
	echo "Activating conda environment: anvio-master"
	echo ""
	conda activate anvio-master
	echo "Activating virtualenv: anvio-master & updating anvio from git repository"
	echo ""
	source ~/virtual-envs/anvio-master/bin/activate
	PS1="(\$CONDA_DEFAULT_ENV) $YELLOW[$USER@$HOSTSTYLE\h$YELLOW:$RED$WD$YELLOW]$RED \$git_branch 🌴 $COLOR_DEFAULT"
}

init_anvio_dev () {
	conda activate /project2/meren/PEOPLE/mschechter/conda-envs/anvio-mschechter
}

# makes alias for these cool functions
# alias ds=deactivate_smart
# alias as=init_anvio_stable
# alias am=init_anvio_master
# alias ad=init_anvio_dev
