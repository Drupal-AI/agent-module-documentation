#!/usr/bin/env bash
# Prepare an installed wave for documentation: resolve each project's real module
# machine names, enable them, and print a manifest the doc agents work from.
#
# Drupal project names and module machine names are not the same thing
# (project `private_files_download_permission` ships module `pfdp`), and
# `drush en` is all-or-nothing, so one un-enableable module would block the whole
# wave. We resolve names from the info.yml files on disk and bisect on failure.
#
# Usage (inside the DDEV web container, cwd = /var/www/html):
#   scripts/wave-prepare.sh --file wave.txt      (one project machine name per line)
#
# Prints a TSV manifest to stdout:
#   <project>\t<version>\t<main_module>\t<enabled|FAILED>\t<submodule,submodule,...>
set -uo pipefail

cd /var/www/html
CONTRIB=web/modules/contrib

projects=()
if [ "${1:-}" = "--file" ]; then
  while read -r n; do [ -n "$n" ] && projects+=("$n"); done < "$2"
else
  projects=("$@")
fi
[ "${#projects[@]}" -gt 0 ] || { echo "usage: wave-prepare.sh --file <list>" >&2; exit 1; }

# The main module of a project is the info.yml at the project root; if there are
# several, prefer one named after the project, else the first alphabetically.
main_module() {
  local dir="$CONTRIB/$1" f best=
  [ -d "$dir" ] || return 1
  if [ -f "$dir/$1.info.yml" ]; then echo "$1"; return 0; fi
  for f in "$dir"/*.info.yml; do
    [ -e "$f" ] || continue
    best=$(basename "$f" .info.yml)
    break
  done
  # Some projects ship NO module at the project root - logging_alerts is only
  # LICENSE.txt plus emaillog/ and errorlog/, each a complete module. Without this
  # fallback the project reports NOT_INSTALLED even though its code is on disk.
  if [ -z "$best" ]; then
    for f in "$dir"/*/*.info.yml; do
      [ -e "$f" ] || continue
      case "$f" in */tests/*) continue ;; esac
      best=$(basename "$f" .info.yml)
      break
    done
  fi
  [ -n "$best" ] && { echo "$best"; return 0; }
  return 1
}

# Every info.yml below the project root that is not the main module.
submodules() {
  local dir="$CONTRIB/$1" main="$2"
  [ -d "$dir" ] || return 0
  find "$dir" -mindepth 2 -name '*.info.yml' -not -path '*/tests/*' 2>/dev/null \
    | while read -r f; do
        n=$(basename "$f" .info.yml)
        [ "$n" = "$main" ] || echo "$n"
      done | sort -u | paste -sd, -
}

# Read the version from the module's own info.yml. `composer show --format=json` prefixes its
# output with a notice when run without a TTY, so json_decode() returns null and every version
# comes back empty (wave 59). The drupal.org packaging script always writes `version:` into a
# released info.yml.
version_of() {
  local d="$CONTRIB/$1" f v
  for f in "$d/$1.info.yml" "$d"/*.info.yml "$d"/*/*.info.yml; do
    [ -f "$f" ] || continue
    v=$(sed -n "s/^version: *['\"]\{0,1\}\([^'\"]*\)['\"]\{0,1\} *$/\1/p" "$f" | head -1)
    [ -n "$v" ] && { echo "$v"; return 0; }
  done
  return 1
}

FAILED_EN=()
try_en() { drush en "$@" -y >/dev/null 2>&1; }
do_en() {
  local n=$#
  if try_en "$@"; then return 0; fi
  if [ "$n" -eq 1 ]; then FAILED_EN+=("$1"); return 1; fi
  local half=$(( n / 2 ))
  do_en "${@:1:half}"
  do_en "${@:half+1}"
}

# Resolve names first, then enable everything resolvable in one bisected pass.
declare -A MAIN
to_enable=()
for p in "${projects[@]}"; do
  if m=$(main_module "$p"); then
    MAIN["$p"]="$m"
    to_enable+=("$m")
  fi
done

# Enable in small chunks, never one giant call. A single `drush en` over a whole wave can
# be interrupted or partially fail partway through, leaving modules in core.extension with
# no system.schema entry — hook_install() never ran, so default config is missing and
# entity types go unregistered while the module still reports as Enabled. That is exactly
# what happened to 41 modules in wave 2.
EN_CHUNK=5
i=0
while [ "$i" -lt "${#to_enable[@]}" ]; do
  chunk=("${to_enable[@]:i:EN_CHUNK}")
  [ "${#chunk[@]}" -gt 0 ] && do_en "${chunk[@]}"
  i=$(( i + EN_CHUNK ))
done
drush cr >/dev/null 2>&1

# Verify each module actually completed installation, and repair any that did not.
if [ -x scripts/repair-half-installed.sh ]; then
  bash scripts/repair-half-installed.sh --repair 5 2>/dev/null | sed 's/^/half-install /' >&2
fi

# A bulk/bisected enable can leave a module in core.extension while its config/install
# defaults were never imported — it looks Enabled but behaves as unconfigured, which
# silently invalidates any doc or eval written against it. Repair before handing the
# wave to the doc agents.
if [ -x scripts/check-default-config.sh ]; then
  CDC_FIX=1 bash scripts/check-default-config.sh 2>/dev/null \
    | grep -E '^(FIXED|FIX-FAILED)' | sed 's/^/default-config /' >&2
fi

enabled_list=$(drush pm:list --status=enabled --field=name 2>/dev/null)

# A module whose code fatals during container build takes down EVERY later drush call, so
# bisection cannot isolate it and the whole wave reports FAILED. state_log did exactly this in
# wave 58 (its StateLog class does not implement StateInterface::getValuesSetDuringRequest,
# added in a newer core, and its service also forms a circular reference). Detect the shape and
# say so, rather than leaving 20 identical FAILED lines to be misread as 20 bad modules.
if [ -z "$enabled_list" ]; then
  echo "wave-prepare: drush returned no enabled modules at all - the site is almost certainly" >&2
  echo "  broken by one module's code being on disk, not by 'drush en' failing per module." >&2
  echo "  Run 'drush status' to see the fatal, remove that module from core.extension by direct" >&2
  echo "  DB edit plus 'composer remove', then re-run this script." >&2
fi

for p in "${projects[@]}"; do
  m="${MAIN[$p]:-}"
  if [ -z "$m" ]; then
    printf '%s\tNOT_INSTALLED\t-\tFAILED\t\n' "$p"
    continue
  fi
  v=$(version_of "$p")
  if echo "$enabled_list" | grep -qx "$m"; then st=enabled; else st=FAILED; fi
  printf '%s\t%s\t%s\t%s\t%s\n' "$p" "${v:-UNKNOWN}" "$m" "$st" "$(submodules "$p" "$m")"
done
