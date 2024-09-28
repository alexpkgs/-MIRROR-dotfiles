eval (starship init elvish)
eval (zoxide init elvish | slurp)
fn time {
    alias time = tty-clock -t -c -s
}