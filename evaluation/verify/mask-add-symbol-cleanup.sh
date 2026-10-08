#!/usr/bin/env bash
# Execution CLEANUP: remove the 'Q' symbol, restoring the shipped table. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("mask.settings");
  $t = $cfg->get("translation") ?: [];
  unset($t["Q"]);
  $cfg->set("translation",$t)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: symbol Q removed"
