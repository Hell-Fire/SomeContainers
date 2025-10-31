#!/bin/sh

[[ -z "$REPOHOST" || -z "$REPOUSER" || -z "$REPOPASS" ]] && echo "Missing repo auth details, need REPOHOST, REPOUSER and REPOPASS" && exit 1

CONFIG='
  {
    "auths": {
      "'"$REPOHOST"'": {
        "auth": "'"$(echo -n "$REPOUSER:$REPOPASS" | base64)"'"
      }
    }
  }
'

mkdir -p $HOME/.docker
echo "$CONFIG" > $HOME/.docker/config.json
