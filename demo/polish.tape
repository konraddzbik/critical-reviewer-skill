# Renders assets/demo-polish.gif by replaying demo/transcripts/polish.txt (a verbatim eval output).
# Run from the repo root: vhs demo/polish.tape
Output assets/demo-polish.gif

Set Shell "bash"
Set FontSize 14
Set Width 1280
Set Height 600
Set Padding 24
Set Theme "Dracula"
Set WindowBar Colorful
Set BorderRadius 10

Hide
Type `export PS1='$ ' && clear && demo/replay.sh demo/transcripts/polish.txt 0.06`
Enter
Show
Sleep 12s
