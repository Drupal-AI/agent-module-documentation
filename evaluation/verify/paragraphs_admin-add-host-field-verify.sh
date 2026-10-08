#!/usr/bin/env bash
# Execution VERIFY: PASS when views.view.paragraphs_admin_task's default display has at least one
# field handler using the paragraphs_admin "Host Entity" plugin (paragraphs_host_entity).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fields = \Drupal::config("views.view.paragraphs_admin_task")->get("display.default.display_options.fields") ?: [];
  $found = FALSE;
  foreach ($fields as $f) {
    if (($f["plugin_id"] ?? "") === "paragraphs_host_entity" || ($f["field"] ?? "") === "paragraphs_host_entity") { $found = TRUE; }
  }
  print ($found ? "PASS" : "FAIL") . " fields=" . implode(",", array_keys($fields)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
