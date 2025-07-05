if status is-interactive
    # Commands to run in interactive sessions can go here
	function fish_greeting
	end

	alias dot='/usr/bin/git --git-dir=$HOME/Downloads/dotfiles.git/ --work-tree=$HOME'

	starship init fish | source
end
