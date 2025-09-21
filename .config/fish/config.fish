if status is-interactive
    # Commands to run in interactive sessions can go here
	function fish_greeting
	end

    # git
    git config --global merge.tool nvimdiff
    git config --global mergetool.nvimdiff.layout LOCAL,MERGED,REMOTE
	alias dot='/usr/bin/git --git-dir=$HOME/Downloads/dotfiles.git/ --work-tree=$HOME'
    dot config --local status.showUntrackedFiles no

    #alacritty
    source "$HOME/.cargo/env.fish"

    # neovim
    alias nvim="nvim -p"
    export EDITOR=nvim
    export SUDO_EDITOR=nvim

    # tmux colors
    set -x TERM xterm-256color

    # eza
    alias ls="eza --group-directories-first --time-style='+%d %b %y %H:%M'"
    alias la='ls -a'
    alias ll='ls -la'
    alias lt='ls -T'
    set --erase LS_COLORS
    set --erase EZA_COLORS
    set EZA_CONFIG_DIR '~/.config/eza'

	starship init fish | source
end
