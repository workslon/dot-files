# navigation
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."
alias server "python -m SimpleHTTPServer 8000"
alias proxy "mitmdump -s replace.py"
alias c "cd ~/leanconvert/clients"
alias p "cd ~/leanconvert/projects"
alias pl "cd ~/leanconvert/playground"
alias dynamodb-local "java -Djava.library.path=.~/dynamodb_local_latest/DynamoDBLocal_lib -jar ~/dynamodb_local_latest/DynamoDBLocal.jar -sharedDb"

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

  if set -q VIRTUAL_ENV
    echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
  end

  echo -n -s $arrow $cwd $git_info $green ' › ' $normal
  source ~/google-cloud-sdk/path.fish.inc
end

# content has to be in .config/fish/config.fish
# if it does not exist, create the file
setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    chmod 600 $SSH_ENV
    . $SSH_ENV > /dev/null
    ssh-add
end

eval (python2.7 -m virtualfish)

set -x GOPATH $HOME/go
set -x PATH $PATH $HOME/go/bin $GOPATH/bin
set -x PATH $PATH $HOME/go/bin $GOROOT/bin
