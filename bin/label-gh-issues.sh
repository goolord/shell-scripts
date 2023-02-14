#!/bin/zsh
set -e
NONE='none'
LABELS=$(echo $NONE; gh label list --json name | jq '.[] | .name' --raw-output)
for i in $(gh issue list --json number,labels | jq '.[] | select(.labels==[]) | .number')
do
  PREVIEW="gh issue view $i"
  LABEL=$(echo $LABELS | fzf --multi --preview $PREVIEW)
  if [ $LABEL = $NONE ];
  then
    echo "skipping $i"
  else
    ADD_LABELS=$(echo $LABEL | tr '\n' ',' | sed 's/,$/\n/')
    gh issue edit $i --add-label "$ADD_LABELS"
  fi
done
