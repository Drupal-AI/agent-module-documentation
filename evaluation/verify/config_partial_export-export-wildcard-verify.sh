#!/usr/bin/env bash
# Execution VERIFY: PASS when BOTH config_partial_export.cpex_wca.yml and cpex_wcb.yml exist in
# the config sync directory with their markers (i.e. a single wildcard export produced both).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
SYNC=$(drush ev 'print \Drupal::service("file_system")->realpath(\Drupal\Core\Site\Settings::get("config_sync_directory"));' 2>/dev/null)
A="$SYNC/config_partial_export.cpex_wca.yml"
B="$SYNC/config_partial_export.cpex_wcb.yml"
if [ -n "$SYNC" ] && [ -f "$A" ] && grep -q 'wca-marker' "$A" && [ -f "$B" ] && grep -q 'wcb-marker' "$B"; then
  echo "PASS both exported: $A , $B"
  exit 0
fi
echo "FAIL a=$( [ -f "$A" ] && echo yes || echo no ) b=$( [ -f "$B" ] && echo yes || echo no )"
exit 1
