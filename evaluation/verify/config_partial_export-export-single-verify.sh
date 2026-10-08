#!/usr/bin/env bash
# Execution VERIFY: PASS when config_partial_export.cpex_task.yml exists in the config sync
# directory and contains the expected marker (i.e. the module exported the active config).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
SYNC=$(drush ev 'print \Drupal::service("file_system")->realpath(\Drupal\Core\Site\Settings::get("config_sync_directory"));' 2>/dev/null)
F="$SYNC/config_partial_export.cpex_task.yml"
if [ -n "$SYNC" ] && [ -f "$F" ] && grep -q 'cpex-task-marker' "$F"; then
  echo "PASS exported=$F"
  exit 0
fi
echo "FAIL missing-or-empty=$F"
exit 1
