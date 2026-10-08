#!/usr/bin/env bash
# Execution VERIFY for "build a view vfp_two whose views_filters_populate filter targets a
# non-exposed numeric filter with machine name exactly nid_target". PASS when views.view.vfp_two
# exists and has a filter handler with plugin_id == views_filters_populate whose `filters`
# option includes "nid_target". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $config = \Drupal::config("views.view.vfp_two");
  $exists = !$config->isNew();
  $data = $config->get();
  $ok = FALSE;
  $targets = [];
  foreach (($data["display"] ?? []) as $display_id => $display) {
    foreach (($display["display_options"]["filters"] ?? []) as $fid => $filter) {
      if (($filter["plugin_id"] ?? NULL) === "views_filters_populate") {
        $f = $filter["filters"] ?? [];
        if (in_array("nid_target", $f, TRUE)) {
          $ok = TRUE;
        }
        $targets = array_merge($targets, array_values($f));
      }
    }
  }
  print (($ok && $exists) ? "PASS" : "FAIL") . " exists=" . ($exists ? "yes" : "no") . " targets=" . implode(",", $targets) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
