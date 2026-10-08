#!/usr/bin/env bash
# Repair modules that are enabled but were never fully installed.
#
# A module listed in core.extension with no system.schema entry means
# ModuleInstaller::install() did not complete: hook_install() never ran, so default config
# may be absent, entity types may be unregistered, and the module can look Enabled while
# silently misbehaving. A large `drush en` that is interrupted or partially fails leaves
# modules in exactly this state.
#
# The only honest repair is a real uninstall + install cycle, so this script does that in
# small batches (a single 40-module drush call is what caused the problem in the first
# place). Modules that refuse to uninstall are reported and skipped, never forced.
#
# Usage (inside the DDEV web container, cwd = /var/www/html):
#   scripts/repair-half-installed.sh --list          # report only
#   scripts/repair-half-installed.sh --repair [N]    # repair, N per batch (default 6)
set -uo pipefail
cd /var/www/html

MODE="${1:---list}"
BATCH="${2:-6}"

list_broken() {
  drush php:eval '
    $ext = \Drupal::config("core.extension")->get("module") ?: [];
    $schema = \Drupal::keyValue("system.schema")->getAll();
    $out = [];
    foreach (array_keys($ext) as $m) { if (!array_key_exists($m, $schema)) { $out[] = $m; } }
    print implode("\n", $out);
  ' 2>/dev/null
}

broken=$(list_broken)
if [ -z "$broken" ]; then echo "no half-installed modules"; exit 0; fi

count=$(echo "$broken" | wc -l | tr -d ' ')
echo "half-installed modules: $count"
echo "$broken" | tr '\n' ' '; echo

[ "$MODE" = "--list" ] && exit 0
[ "$MODE" = "--repair" ] || { echo "usage: --list | --repair [batch]" >&2; exit 1; }

mapfile -t mods <<< "$broken"
i=0
while [ "$i" -lt "${#mods[@]}" ]; do
  chunk=("${mods[@]:i:BATCH}")
  echo "--- repairing: ${chunk[*]}"
  # Uninstall first so the subsequent install runs hook_install() for real. Failures are
  # reported, not forced: a module that will not uninstall is left exactly as it was.
  if ! drush pm:uninstall "${chunk[@]}" -y >/dev/null 2>&1; then
    echo "    batch uninstall failed, falling back to one at a time"
    for m in "${chunk[@]}"; do
      drush pm:uninstall "$m" -y >/dev/null 2>&1 || echo "    UNINSTALL-FAILED $m"
    done
  fi
  for m in "${chunk[@]}"; do
    drush en "$m" -y >/dev/null 2>&1 || echo "    ENABLE-FAILED $m"
  done
  i=$(( i + BATCH ))
done

drush cr >/dev/null 2>&1
echo "--- post-repair state ---"
still=$(list_broken)
if [ -z "$still" ]; then echo "all repaired"; else echo "STILL BROKEN: $(echo "$still" | tr '\n' ' ')"; fi
