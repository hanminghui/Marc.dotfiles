#! /bin/bash

# Backup config files

destination=$PWD

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

echo ================================================================================
echo Start backup
echo --------------------------------------------------------------------------------
count=0
update=0
for old in ${files[@]}
do
new="${old##*/}"
info=" INFO "
if [[ -e $old ]]
then # old exist
	if [[ -e $new ]]
	then # new exist, check need to update
		if diff -r "$old" "$new" > /dev/null
		then # do nothing
			info=" KEEP "
			if [[ -d $old ]]
			then
				count=$((count+1))
				echo -e "Successfully backup directory \033[1m[$info]\033[0m: $old"
			elif [[ -f $old ]]
			then
				count=$((count+1))
				echo -e "Successfully backup file      \033[1m[$info]\033[0m: $old"
			fi
		else # update
			info="UPDATE"
			if [[ -d $old ]]
			then
				count=$((count+1))
				update=$((update+1))
				cp -r $old $destination
				echo -e "Successfully backup directory \033[1;38;5;48m[$info]\033[0m: $old"
			elif [[ -f $old ]]
			then
				count=$((count+1))
				update=$((update+1))
				cp $old $destination
				echo -e "Successfully backup file      \033[1;38;5;48m[$info]\033[0m: $old"
			fi
		fi
	else # new not exist, create
		info="CREATE"
		if [[ -d $old ]]
		then
			count=$((count+1))
			update=$((update+1))
			cp -r $old $destination
			echo -e "Successfully backup directory \033[1;38;5;226m[$info]\033[0m: $old"
		elif [[ -f $old ]]
		then
			count=$((count+1))
			update=$((update+1))
			cp $old $destination
			echo -e "Successfully backup file      \033[1;38;5;226m[$info]\033[0m: $old"
		fi
	fi
else # old not exist
	info=" NULL "
	echo -e "No such file or directory     \033[1;38;5;196m[$info]\033[0m: ${old}"
fi
done
echo --------------------------------------------------------------------------------
all=${#files[@]}
fail=$(($all-$count))
keep=$(($count-$update))
echo Success: $count, Update: $update, Keep: $keep, Fail: $fail, in $all files
echo ================================================================================
