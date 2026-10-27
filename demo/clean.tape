# Renders assets/demo-clean.gif by replaying demo/transcripts/clean.txt (a verbatim eval output).
# Run from the repo root: vhs demo/clean.tape
Output assets/demo-clean.gif

Set Shell "bash"
Set FontSize 14
Set Width 1280
Set Height 580
Set Padding 24
Set Theme "Dracula"
Set WindowBar Colorful
Set BorderRadius 10

Hide
Type `export PS1='$ ' && clear && demo/replay.sh demo/transcripts/clean.txt 0.06`
Enter
Show
Sleep 12s
