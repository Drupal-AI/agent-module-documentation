#!/usr/bin/env bash
# Execution VERIFY: PASS when the onlyone_admin_toolbar submodule is installed AND
# onlyone_atb_task is restricted in onlyone.settings (so the toolbar will annotate it).
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $mod = \Drupal::moduleHandler()->moduleExists("onlyone_admin_toolbar");
  $types = \Drupal::config("onlyone.settings")->get("onlyone_node_types") ?: [];
  $restricted = in_array("onlyone_atb_task", $types, true);
  $ok = $mod && $restricted;
  print ($ok ? "PASS" : "FAIL") . " submodule=" . ($mod?"on":"off") . " restricted=" . ($restricted?"yes":"no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
