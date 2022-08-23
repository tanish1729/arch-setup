################################################
#                fish config                   #
#                                              #
# Author - Tanish                              #
# Github - https://github.com/tanish1729       #
# Docs - https://github.com/fish-shell/        #
#                                              #
################################################

# Basic Settings

set -e fish_user_paths
set -U fish_user_paths ~/.local/bin ~/Applications $fish_user_paths

set fish_greeting

starship init fish | source
colorscript random

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Aliases

alias configs='cd ~/.config/'
alias college='cd ~/Desktop/IIITH/Sem\ 3/'
alias coding='code ~/Desktop/Code/ && cd ~/Desktop/Code'
alias desktop='cd ~/Desktop/'
alias downloads='cd ~/Downloads/'
alias deadlines='cd ~/.config/polybar-deadlines && bash deadline.sh'

alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a' 
alias ll='exa -l --color=always --group-directories-first' 
alias lt='exa -aT --color=always --group-directories-first' 
alias l.='exa -a | egrep "^\."'

alias vim='nvim'

alias clear='echo -en "\x1b[2J\x1b[1;1H" ; echo; echo; seq 1 (tput cols) | sort -R | spark | lolcat; echo; echo'

alias rickroll='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh'

# Colors

set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan


### SPARK ### (needed for clear)
set -g spark_version 1.0.0

complete -xc spark -n __fish_use_subcommand -a --help -d "Show usage help"
complete -xc spark -n __fish_use_subcommand -a --version -d "$spark_version"
complete -xc spark -n __fish_use_subcommand -a --min -d "Minimum range value"
complete -xc spark -n __fish_use_subcommand -a --max -d "Maximum range value"

function spark -d "sparkline generator"
    if isatty
        switch "$argv"
            case {,-}-v{ersion,}
                echo "spark version $spark_version"
            case {,-}-h{elp,}
                echo "usage: spark [--min=<n> --max=<n>] <numbers...>  Draw sparklines"
                echo "examples:"
                echo "       spark 1 2 3 4"
                echo "       seq 100 | sort -R | spark"
                echo "       awk \\\$0=length spark.fish | spark"
            case \*
                echo $argv | spark $argv
        end
        return
    end

    command awk -v FS="[[:space:],]*" -v argv="$argv" '
        BEGIN {
            min = match(argv, /--min=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
            max = match(argv, /--max=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
        }
        {
            for (i = j = 1; i <= NF; i++) {
                if ($i ~ /^--/) continue
                if ($i !~ /^-?[0-9]/) data[count + j++] = ""
                else {
                    v = data[count + j++] = int($i)
                    if (max == "" && min == "") max = min = v
                    if (max < v) max = v
                    if (min > v ) min = v
                }
            }
            count += j - 1
        }
        END {
            n = split(min == max && max ? "▅ ▅" : "▁ ▂ ▃ ▄ ▅ ▆ ▇ █", blocks, " ")
            scale = (scale = int(256 * (max - min) / (n - 1))) ? scale : 1
            for (i = 1; i <= count; i++)
                out = out (data[i] == "" ? " " : blocks[idx = int(256 * (data[i] - min) / scale) + 1])
            print out
        }
    '
end
### END OF SPARK ###
