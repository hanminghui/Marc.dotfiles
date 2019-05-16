#! /bin/bash

# Backup config files

files=()
# vim
files+=($HOME/.vimrc)
files+=($HOME/.vim/UltiSnipsSnippets)
# tmux
files+=($HOME/.tmux.conf)
# i3
files+=($HOME/.config/i3)
# X
files+=($HOME/.Xresources)
# git
files+=($HOME/.gitconfig)
# zsh
files+=($HOME/.zshrc)
files+=($HOME/.zprofile)
# some scripts
files+=($HOME/scripts)

echo ==================================================
echo Start backup
echo --------------------------------------------------
count=0
for i in ${files[@]}
do
	if [[ -d $i ]]
	then
		count=$((count+1))
		cp -r $i ./
		echo "Successfully backup directory: $i"
	elif [[ -f $i ]]
	then
		count=$((count+1))
		cp $i ./
		echo "Successfully backup file     : $i"
	else
		echo  -e "\033[38;5;202mNo such file or directory    : ${i}\033[0m"
	fi
done
echo --------------------------------------------------
all=${#files[@]}
fail=$(($all-$count))
echo Success: $count, Fail: $fail, in $all files
echo ==================================================
