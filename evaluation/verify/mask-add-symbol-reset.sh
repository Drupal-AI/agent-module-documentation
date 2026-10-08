#!/usr/bin/env bash
# Execution RESET: ensure the custom symbol 'Q' is NOT present in mask.settings translation
# (so verify FAILS until the agent adds it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("mask.settings");
  $t = $cfg->get("translation") ?: [];
  unset($t["Q"]);
  $cfg->set("translation",$t)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: symbol Q absent from mask.settings"
