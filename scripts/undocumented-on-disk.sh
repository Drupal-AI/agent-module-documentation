#!/usr/bin/env bash
# List contrib modules that are already in web/modules/contrib but have no docs yet.
#
# Composer pulls dependencies, and dependencies are modules too - over 50 waves the site
# accumulated 50+ modules that were never on any wave list because nobody required them
# directly. They need no composer resolution (they are already on disk, already D11-resolvable,
# usually already enabled), so they are the cheapest documentation targets available and
# cannot fail to install. Wave 53 was built entirely from this pool.
#
# Matching mirrors next-wave.sh: a project is "documented" if a directory named after it OR
# after its main module machine name exists under modules/ (two-letter bucket) or as a nested
# submodule. That handles project->module renames (project `confi` ships module `config_import`).
#
# Usage (from the repo root, host or container):
#   scripts/undocumented-on-disk.sh              # names only
#   scripts/undocumented-on-disk.sh --verbose    # name, main module, core_version_requirement
set -uo pipefail
cd "$(dirname "$0")/.."

VERBOSE=
[ "${1:-}" = "--verbose" ] && VERBOSE=1

CONTRIB="${CONTRIB_DIR:-../web/modules/contrib}"
[ -d "$CONTRIB" ] || CONTRIB="/var/www/html/web/modules/contrib"
[ -d "$CONTRIB" ] || { echo "cannot find web/modules/contrib" >&2; exit 1; }

# Every documented directory name: modules/{ab}/{name} and modules/{ab}/{parent}/modules/{sub}
documented=$(
  { ls -1 modules/*/ 2>/dev/null | sed 's:/$::'
    ls -1d modules/*/*/modules/*/ 2>/dev/null | awk -F/ '{print $(NF-1)}'
  } | sort -u
)

for dir in "$CONTRIB"/*/; do
  [ -d "$dir" ] || continue
  proj=$(basename "$dir")
  # Main module = info.yml named after the project, else first alphabetically.
  main=""
  if [ -f "$dir/$proj.info.yml" ]; then
    main="$proj"
  else
    for f in "$dir"/*.info.yml; do
      [ -e "$f" ] || continue
      main=$(basename "$f" .info.yml)
      break
    done
  fi
  [ -n "$main" ] || continue

  if grep -qx "$proj" <<<"$documented" || grep -qx "$main" <<<"$documented"; then
    continue
  fi

  if [ -n "$VERBOSE" ]; then
    cvr=$(grep -h '^core_version_requirement' "$dir/$main.info.yml" 2>/dev/null | cut -d: -f2- | tr -d " '\"")
    printf '%-34s %-34s %s\n' "$proj" "$main" "${cvr:-?}"
  else
    echo "$proj"
  fi
done
