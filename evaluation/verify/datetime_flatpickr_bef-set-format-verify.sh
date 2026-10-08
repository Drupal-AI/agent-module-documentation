#!/usr/bin/env bash
# Execution VERIFY: PASS when dtf_bef_view2 created bef_flatpickr dateFormat is d/m/Y.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $base = "display.default.display_options.exposed_form.options.bef.filter.created";
  $cfg = \Drupal::config("views.view.dtf_bef_view2");
  $p = $cfg->get($base.".plugin_id");
  $f = $cfg->get($base.".dateFormat");
  $ok = ($p === "bef_flatpickr" && $f === "d/m/Y");
  print ($ok ? "PASS" : "FAIL") . " plugin_id=" . var_export($p, TRUE) . " dateFormat=" . var_export($f, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
