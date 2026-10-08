#!/usr/bin/env bash
# Execution VERIFY for "build a view vfp_task with a views_filters_populate filter handler
# whose filters option is non-empty". PASS when views.view.vfp_task exists and at least one
# filter handler, in any display, has plugin_id == views_filters_populate and a non-empty
# `filters` option. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $config = \Drupal::config("views.view.vfp_task");
  $exists = !$config->isNew();
  $data = $config->get();
  $ok = FALSE;
  $targets = [];
  foreach (($data["display"] ?? []) as $display_id => $display) {
    foreach (($display["display_options"]["filters"] ?? []) as $fid => $filter) {
      if (($filter["plugin_id"] ?? NULL) === "views_filters_populate") {
        $f = $filter["filters"] ?? [];
        if (!empty($f)) {
          $ok = TRUE;
          $targets = array_values($f);
        }
      }
    }
  }
  print (($ok && $exists) ? "PASS" : "FAIL") . " exists=" . ($exists ? "yes" : "no") . " targets=" . implode(",", $targets) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
