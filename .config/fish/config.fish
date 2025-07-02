if status is-interactive
    # Commands to run in interactive sessions can go here
	set fish_greeting
	alias dot='/usr/bin/git --git-dir=$HOME/Downloads/dotfiles.git/ --work-tree=$HOME'
end
