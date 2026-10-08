#!/usr/bin/env bash
# Execution VERIFY: PASS when the "created" filter on view sdt_exp_task is now EXPOSED and is
# still the absolute-date filter single_datetime_exposed enhances — i.e. exposed === true AND
# plugin_id === "date" AND value.type === "date". Reads raw config (no Views handler discovery,
# so it is immune to the unrelated filter-plugin fatal). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::config("views.view.sdt_exp_task")->get("display.default.display_options.filters.created");
  $exposed = !empty($f["exposed"]);
  $plugin = $f["plugin_id"] ?? "none";
  $vtype = $f["value"]["type"] ?? "none";
  $ok = ($exposed && $plugin === "date" && $vtype === "date");
  print ($ok ? "PASS" : "FAIL") . " exposed=" . var_export($exposed, TRUE) . " plugin=" . $plugin . " vtype=" . $vtype . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
