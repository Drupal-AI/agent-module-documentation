#!/usr/bin/env bash
# Execution VERIFY: PASS when dtf_bef_view created filter BEF plugin_id is bef_flatpickr.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::config("views.view.dtf_bef_view")->get("display.default.display_options.exposed_form.options.bef.filter.created.plugin_id");
  $ok = ($p === "bef_flatpickr");
  print ($ok ? "PASS" : "FAIL") . " plugin_id=" . var_export($p, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
