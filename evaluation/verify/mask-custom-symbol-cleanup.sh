#!/usr/bin/env bash
# Introspection CLEANUP: remove the custom 'Z' symbol, restoring the shipped 5-symbol table.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("mask.settings");
  $t = $cfg->get("translation") ?: [];
  unset($t["Z"]);
  $cfg->set("translation",$t)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: symbol Z removed"
