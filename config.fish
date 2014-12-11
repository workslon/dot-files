# navigation
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."
alias p "cd ~/Dropbox/public/devel/projects"
alias mm "cd ~/Dropbox/public/devel/projects/Maxymiser/DE"
alias s "cd ~/Dropbox/public/devel/projects/Slon"
alias htd "/Applications/MAMP/htdocs"
alias h "history"

# git shortcuts
alias g "git"

function fish_prompt
	# set_color yellow
	# echo -n (date +'%H:%M') ' '
	# set_color cyan
	# echo -n (pwd)
	# set_color green
	#echo -n ' ❯'

	if not set -q -g __fish_robbyrussell_functions_defined
	set -g __fish_robbyrussell_functions_defined
	function _git_branch_name
		echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
	end

	function _is_git_dirty
		echo (git status -s --ignore-submodules=dirty ^/dev/null)
	end
	end

	set -l cyan (set_color -o cyan)
	set -l yellow (set_color -o yellow)
	set -l red (set_color -o red)
	set -l blue (set_color -o blue)
	set -l green (set_color -o green)
	set -l normal (set_color normal)

	set -l arrow "$yellow" (date +'%H:%M') ' '
	set -l cwd $cyan(basename (prompt_pwd))

	if [ (_git_branch_name) ]
	set -l git_branch $red(_git_branch_name)
	set git_info "$blue git:$git_branch$blue"

	if [ (_is_git_dirty) ]
		set -l dirty "$yellow ✗"
		set git_info "$git_info$dirty"
	end
	end

	echo -n -s $arrow $cwd $git_info $green ' ❯ ' $normal

end
