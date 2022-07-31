#!/bin/bash

SYMBOL_WORKSPACE_EMPTY="○"
SYMBOL_WORKSPACE_OCCUPIED="◒"
SYMBOL_WORKSPACE_FOCUSED="◉"

bspc subscribe desktop_focus | while read -r event; do
    occupied_workspaces="$(bspc query -D -d .occupied --names)"
    highest_occupied_workspace=$(echo "$occupied_workspaces" | sort -nr | head -n1)
    current_workspace=$(bspc query -D -d .focused --names)
    highest_workspace=$(( current_workspace > highest_occupied_workspace ? current_workspace : highest_occupied_workspace))

    workspace_string=""
    
    for ((w = 1; w <= $highest_workspace; w++)); do
        wsymbol=$SYMBOL_WORKSPACE_EMPTY
        if [[ $current_workspace == $w ]]; then
            wsymbol=$SYMBOL_WORKSPACE_FOCUSED
        elif [[ $occupied_workspaces =~ $w ]]; then
            wsymbol=$SYMBOL_WORKSPACE_OCCUPIED
        fi
        
        workspace_string="$workspace_string $wsymbol"
    done
    
    echo $workspace_string
done
