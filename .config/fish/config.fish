if status is-interactive
    # Commands to run in interactive sessions can go here
	function fish_greeting
	end

    # git
    git config --global merge.tool nvimdiff
    git config --global mergetool.nvimdiff.layout LOCAL,MERGED,REMOTE
	alias dot='/usr/bin/git --git-dir=$HOME/Downloads/dotfiles.git/ --work-tree=$HOME'

    # neovim
    export EDITOR=nvim
    export SUDO_EDITOR=nvim

	starship init fish | source
end
