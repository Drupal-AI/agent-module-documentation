#!/usr/bin/env bash
# Execution VERIFY for "take a config_sync snapshot of the views_migration module".
# PASS when a config_snapshot entity 'config_sync.module.views_migration' exists. Prints PASS/FAIL;
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\config_snapshot\Entity\ConfigSnapshot;
  $s = ConfigSnapshot::load("config_sync.module.views_migration");
  $ok = (bool) $s;
  print ($ok ? "PASS" : "FAIL") . " snapshot=" . ($s ? $s->id() : "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
