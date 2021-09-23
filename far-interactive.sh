#!/bin/bash
DIR="$0"

function fzf_search () {
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  FZF_DEFAULT_COMMAND="$RG_PREFIX ''" \
    fzf --bind "change:reload:$RG_PREFIX {q} || true" \
        --ansi --disabled \
        --height=50% --layout=reverse \
        --print-query
}

SEARCH_TXT="$(fzf_search | head -1)"

echo $SEARCH_TXT
echo
echo

FILES=$(rg --smart-case -l \""$SEARCH_TXT"\" | cat)
echo $FILES
echo
echo

function fzf_replace () {
  export 
  SED_PREFIX="sed -n -e 's@$SEARCH_TXT@{q}@gp' $FILES"
  FZF_DEFAULT_COMMAND="$SED_PREFIX" \
    fzf --bind "change:reload:$SED_PREFIX || true" \
        --ansi --disabled \
        --height=50% --layout=reverse \
        --print-query
}

REPLACE_RES="$(fzf_replace)"
REPLACE_TXT=("${REPLACE_RES[0]}")

echo "looks good?"
read -r confirm

case $confirm in
  'y') 
    sed -i -e "s@$SEARCH_TXT@$REPLACE_TXT@g" "$FILES"
    ;;
  'n') 
    exit
    ;;
esac
