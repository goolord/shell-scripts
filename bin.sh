# directory of shell-scripts
DIR="$( { cd "$(dirname "$0")" || exit; } ; pwd -P )"

stow bin -d "$DIR" -t ~/.local/bin
