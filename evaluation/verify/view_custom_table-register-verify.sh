#!/usr/bin/env bash
# Execution VERIFY (view_custom_table): PASS when vct_task is registered in view_custom_table.tables
# AND the module has exposed it to Views as a base table (views_data 'vct_task' has table.base).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("view_custom_table.tables")->get("vct_task");
  \Drupal::service("views.views_data")->clear();
  $d = \Drupal::service("views.views_data")->get("vct_task");
  $registered = is_array($c) && ($c["table_name"] ?? NULL) === "vct_task";
  $isbase = isset($d["table"]["base"]);
  $ok = $registered && $isbase;
  print ($ok ? "PASS" : "FAIL") . " registered=" . var_export($registered, TRUE) . " views_base=" . var_export($isbase, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
