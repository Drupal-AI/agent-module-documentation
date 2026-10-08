#!/usr/bin/env bash
# Execution RESET/CLEANUP: remove ONLY dropsolid_purge purger instances from purge.plugins (other
# agents' purgers are preserved), so verify FAILS on baseline and the site is left clean. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory()->getEditable("purge.plugins");
  $purgers = $cf->get("purgers") ?: [];
  $kept = array_values(array_filter($purgers, fn($p) => ($p["plugin_id"] ?? "") !== "dropsolid_purge"));
  $cf->set("purgers", $kept)->save();
' >/dev/null 2>&1
echo "reset: removed any dropsolid_purge purger instances from purge.plugins"
