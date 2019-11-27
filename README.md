# Instructions for deploying BASH environment

1. Move new machine's bash configurations into a file for safe keeping

```
mkdir ~/dotfiles/oldconfig

mv .bash_profile  ~/dotfiles/oldconfig

mv .bashrc ~/dotfiles/oldconfig
```

2. add .gitignore to ~/dotfiles/ , this make it so that the old bag configurations from the current machine are not tracked

```
cd ~/dotfiles

touch .gitignore

ls ~/dotfiles/oldconfig >> .gitignore
```

3. Create new .bash_profile and .bashrc in ~ 

```
cd ~

touch .bash_profile

touch .bashrc
```

2. In ~/.bash_profile write the code below. This if/then statement source the .bashrc file rather then the .bash_profile 

```
# write in .bash_profile

if [ -f ~/.bashrc ]; then
	source .bashrc
fi
```

2. In  ~/.bashrc write the code below. This sources the .bashrc you cloned from your repo

```
# write in .bashrc

echo "source ~/dotfiles/terminal/bashrc" > .bashrc
```

3. Make some extra files to point to where your terminal configs are
```
echo "source ~/dotfiles/terminal/bash-aliases" > .bash-aliases

echo "source ~/dotfiles/terminal/bash-functions" > .bash-functions

echo "source ~/dotfiles/terminal/bash-prompt" > .bash-prompt
 ```


 ```
cd ~

mv .vimrc .vimrc_old

echo "source ~/dotfiles/vim/vimrc" > .vimrc
 ```
