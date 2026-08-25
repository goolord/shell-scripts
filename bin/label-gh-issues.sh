#!/bin/zsh
set -e
NONE='none'
LABELS=$(echo $NONE; gh label list --json name | jq '.[] | .name' --raw-output)
for i in $(gh issue list --json number,labels | jq '.[] | select(.labels==[]) | .number')
do
  PREVIEW="gh issue view $i"
  # fzf exits nonzero on esc; don't let set -e kill the loop
  LABEL=$(echo $LABELS | fzf --multi --preview $PREVIEW --preview-window='right:70%' || true)
  # drop 'none' from the selection in case it was picked alongside real labels
  LABEL=$(echo $LABEL | grep -vx "$NONE" || true)
  if [ -z "$LABEL" ];
  then
    echo "skipping $i"
  else
    ADD_LABELS=$(echo $LABEL | tr '\n' ',' | sed 's/,$/\n/')
    gh issue edit $i --add-label "$ADD_LABELS"
  fi
done
