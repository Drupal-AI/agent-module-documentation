#!/usr/bin/env bash
# Pre-filter project names by whether a Drupal 11 compatible release actually exists.
#
# Composer resolution is slow (1-3 minutes per project on a large site) and most campaign
# failures are simply "no D11 release exists" - wave 52 lost 26 of 40 projects that way
# before anyone read a composer error. This check costs one HTTP request per project.
#
# It reads **Packagist metadata**, i.e. the same `require: {"drupal/core": ...}` constraints
# composer resolves against, and reports D11 if any non-dev version allows a 11.x core.
#
#   Do NOT use drupal.org's release-history <core_compatibility> field for this. It is
#   maintained separately from the package's composer.json and the two disagree: md_slider
#   advertises "^9 || ^10 || ^11" on one release while every installable version
#   (1.5.0-1.5.5) requires drupal/core "^9 || ^10". That mismatch produced false positives
#   in the wave 54 scan - projects passed the filter and then failed to install.
#
# Still a pre-filter, not an oracle: a project can have a D11-compatible release and still
# fail to install because one of its *other* dependencies conflicts with something the site
# already has pinned (drupal/aos needs animate_on_scroll ^1|^2, this site pins ^3.0).
# Composer remains the arbiter.
#
# Usage (host or container; needs curl + php or python3):
#   scripts/check-d11.sh name1 name2 ...
#   scripts/check-d11.sh --file list.txt
#   scripts/next-wave.sh 200 | scripts/check-d11.sh --stdin --only-ok > wave.txt
#
# Prints:  <project>\t<D11|NO-D11|UNKNOWN>   (--only-ok prints just the D11 names)
set -uo pipefail

ONLY_OK=
names=()

while [ $# -gt 0 ]; do
  case "$1" in
    --only-ok) ONLY_OK=1; shift ;;
    --stdin)   while read -r n; do [ -n "$n" ] && names+=("$n"); done; shift ;;
    --file)    while read -r n; do [ -n "$n" ] && names+=("$n"); done < "$2"; shift 2 ;;
    *)         names+=("$1"); shift ;;
  esac
done

[ "${#names[@]}" -gt 0 ] || { echo "usage: check-d11.sh [--only-ok] <name...> | --file <list> | --stdin" >&2; exit 1; }

check_one() {
  local m="$1" json
  # Drupal contrib lives on packages.drupal.org, NOT packagist.org (which 404s for drupal/*).
  # Use the /files/packages/ path directly: /8/p2/ issues a 302 that -L follows to an HTML
  # page, not to the JSON.
  json=$(curl -s --max-time 20 "https://packages.drupal.org/files/packages/8/p2/drupal/$m.json") || json=''
  if [ -z "$json" ] || ! printf '%s' "$json" | head -c 1 | grep -q '{'; then
    printf '%s\tUNKNOWN\n' "$m"
    return
  fi
  printf '%s\t%s\n' "$m" "$(
    printf '%s' "$json" | python3 -c '
import json, re, sys
try:
    data = json.load(sys.stdin)
except Exception:
    print("UNKNOWN"); raise SystemExit
versions = []
packages = data.get("packages") or {}
if isinstance(packages, dict):
    for pkgs in packages.values():
        if isinstance(pkgs, list):
            versions.extend(v for v in pkgs if isinstance(v, dict))
if not versions:
    print("UNKNOWN"); raise SystemExit
for v in versions:
    core = (v.get("require") or {}).get("drupal/core", "")
    if not core:
        continue
    # Any constraint clause that admits an 11.x core: ^11, ~11, >=11, 11.x, || ^11.2 ...
    if re.search(r"(\^|~|>=|>)\s*11(\.|\b)|(\b11\.x)|(\*)", core):
        print("D11"); raise SystemExit
print("NO-D11")
'
  )"
}
export -f check_one

printf '%s\n' "${names[@]}" \
  | xargs -P 12 -I{} bash -c 'check_one "$@"' _ {} \
  | if [ -n "$ONLY_OK" ]; then awk -F'\t' '$2=="D11"{print $1}'; else cat; fi
