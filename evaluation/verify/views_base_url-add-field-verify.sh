#!/usr/bin/env bash
# Execution VERIFY: PASS when views.view.views_base_url_task's default display has a field
# handler using the views_base_url "base_url" plugin. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fields = \Drupal::config("views.view.views_base_url_task")->get("display.default.display_options.fields") ?: [];
  $found = FALSE;
  foreach ($fields as $f) {
    if (($f["plugin_id"] ?? "") === "base_url" || ($f["field"] ?? "") === "base_url") { $found = TRUE; }
  }
  print ($found ? "PASS" : "FAIL") . " fields=" . implode(",", array_keys($fields)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
