#!/usr/bin/env bash
# Execution VERIFY for "expose the created filter of view date_filter_task and set the
# date_filter Filter type to Date and time".
# PASS when views.view.date_filter_task display.default...filters.created has
#   plugin_id=date, exposed=TRUE, operator=between and top-level type="datetime"
#   (date_filter's option -- NOT core's value.type).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("date_filter_task");
  $f = NULL;
  if ($v) {
    $d = $v->get("display");
    $f = $d["default"]["display_options"]["filters"]["created"] ?? NULL;
  }
  $plugin   = $f["plugin_id"] ?? "none";
  $exposed  = !empty($f["exposed"]);
  $operator = $f["operator"] ?? "none";
  $type     = $f["type"] ?? "unset";
  $ok = ($plugin === "date" && $exposed && $operator === "between" && $type === "datetime");
  print ($ok ? "PASS" : "FAIL")
    . " plugin_id=" . $plugin
    . " exposed=" . var_export($exposed, TRUE)
    . " operator=" . $operator
    . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
