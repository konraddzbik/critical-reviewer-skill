# Renders assets/demo-security.gif by replaying demo/transcripts/security.txt (a verbatim eval output).
# Run from the repo root: vhs demo/security.tape
Output assets/demo-security.gif

Set Shell "bash"
Set FontSize 14
Set Width 1280
Set Height 860
Set Padding 24
Set Theme "Dracula"
Set WindowBar Colorful
Set BorderRadius 10

Hide
Type `export PS1='$ ' && clear && demo/replay.sh demo/transcripts/security.txt 0.06`
Enter
Show
Sleep 12s
