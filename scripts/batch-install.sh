#!/usr/bin/env bash
# Resilient bulk installer for the documentation campaign.
#
# Takes a list of Drupal module machine names and installs them with a single
# `composer require` where possible. Composer resolves all-or-nothing, so one
# unsatisfiable module would sink an entire batch; instead we bisect on failure
# and isolate the bad ones.
#
# Usage (inside the DDEV web container, cwd = /var/www/html):
#   scripts/batch-install.sh name1 name2 name3 ...
#   scripts/batch-install.sh --file wave.txt        (one machine name per line)
#
# Writes a TSV report to stdout:  <machine_name>\t<installed_version|FAILED>
set -uo pipefail

cd /var/www/html

names=()
if [ "${1:-}" = "--file" ]; then
  while read -r n; do [ -n "$n" ] && names+=("$n"); done < "$2"
else
  names=("$@")
fi
[ "${#names[@]}" -gt 0 ] || { echo "usage: batch-install.sh <name...> | --file <list>" >&2; exit 1; }

FAILED=()

# try <names...> -> 0 if the whole set installed together
try() {
  local pkgs=()
  local n
  for n in "$@"; do pkgs+=("drupal/$n"); done
  composer require "${pkgs[@]}" -W --no-interaction --no-progress >/dev/null 2>&1
}

# install <names...> — install the set, bisecting to isolate failures
install() {
  local n=$#
  if try "$@"; then return 0; fi
  if [ "$n" -eq 1 ]; then
    FAILED+=("$1")
    return 1
  fi
  local half=$(( n / 2 ))
  local left=("${@:1:half}")
  local right=("${@:half+1}")
  install "${left[@]}"
  install "${right[@]}"
}

install "${names[@]}"

# Report the resolved version for everything that made it into the lock file.
for n in "${names[@]}"; do
  skip=
  for f in ${FAILED[@]+"${FAILED[@]}"}; do [ "$f" = "$n" ] && skip=1; done
  if [ -n "$skip" ]; then
    printf '%s\tFAILED\n' "$n"
    continue
  fi
  v=$(composer show "drupal/$n" --format=json 2>/dev/null \
        | php -r '$j=json_decode(stream_get_contents(STDIN),true); echo $j["versions"][0] ?? "";' 2>/dev/null)
  printf '%s\t%s\n' "$n" "${v:-UNKNOWN}"
done
