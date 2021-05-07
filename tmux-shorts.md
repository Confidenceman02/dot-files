# Panes
## Hide and show a pane in the same tmux session.

[reference](https://itectec.com/unixlinux/how-to-hide-a-tmux-pane/)

Whilst in the pane you wish to hide.
`Prefix`-`:break-pane -dP`

Tmux will give you some info about the hidden pane i.e. `1:2.0` which maps to `session:window.pane`.

To get the pane back.
`Prefix`-`:join-pane -vs 1:2.0`

This tells tmux to split the current pane vertically (`-v`) and to join the source pane (`-s`) with identifier `1:2.0`.
You don't need to add the `session` or the `pane` parts of the identifier.

## Resize pane
`Prefix C-up`, `Prefix C-down`, `Prefix C-left`, `Prefix C-right` resizes by 1 row/column

