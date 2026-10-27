#!/usr/bin/env bash
# Replays a captured review transcript line by line with severity colors.
# Used only by the VHS tapes in this folder to render the README GIFs; the
# transcripts in demo/transcripts/ are verbatim outputs from eval runs (re-wrapped;
# markdown ** and backticks are stripped for the terminal).
set -euo pipefail
file="$1"
delay="${2:-0.05}"

red=$'\e[1;31m'; orange=$'\e[38;5;208m'; yellow=$'\e[33m'; green=$'\e[32m'
cyan=$'\e[36m'; dim=$'\e[2m'; bold=$'\e[1m'; reset=$'\e[0m'

# The first line is the "$ claude ..." prompt: type it out, then pause like a real run.
IFS= read -r prompt < "$file"
for ((i = 0; i < ${#prompt}; i++)); do printf '%s' "${prompt:i:1}"; sleep 0.035; done
sleep 0.8
printf '\n'

tail -n +2 "$file" | while IFS= read -r line || [[ -n "$line" ]]; do
  line="${line//\*\*/}"; line="${line//\`/}"
  line="${line//\[catastrophe\]/${red}[catastrophe]${reset}}"
  line="${line//\[katastrofa\]/${red}[katastrofa]${reset}}"
  line="${line//\[poor\]/${orange}[poor]${reset}}"
  line="${line//\[słabe\]/${orange}[słabe]${reset}}"
  line="${line//\[needs-work\]/${yellow}[needs-work]${reset}}"
  line="${line//\[do poprawy\]/${yellow}[do poprawy]${reset}}"
  line="${line//\[nit\]/${dim}[nit]${reset}}"
  case "$line" in
    Verdict:*catastrophe*|Werdykt:*katastrofa*) line="${bold}${line%%:*}:${reset}${red}${line#*:}${reset}" ;;
    Verdict:*poor*|Werdykt:*słabe*) line="${bold}${line%%:*}:${reset}${orange}${line#*:}${reset}" ;;
    Verdict:*needs-work*|Werdykt:*"do poprawy"*) line="${bold}${line%%:*}:${reset}${yellow}${line#*:}${reset}" ;;
    Verdict:*solid*|Werdykt:*solidne*) line="${bold}${line%%:*}:${reset}${green}${line#*:}${reset}" ;;
    Verdict:*clean*|Werdykt:*czyste*) line="${bold}${line%%:*}:${reset}${cyan}${line#*:}${reset}" ;;
    Issues:*|Problemy:*|Summary:*|Podsumowanie:*|"What's good:"*|Dobre:*) line="${bold}${line%%:*}:${reset}${line#*:}" ;;
  esac
  printf '%s\n' "$line"
  sleep "$delay"
done
