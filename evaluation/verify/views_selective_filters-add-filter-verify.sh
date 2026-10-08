#!/usr/bin/env bash
# Execution VERIFY: PASS when the vsf_eval_hard view has at least one filter whose plugin_id
# is views_selective_filters_filter (i.e. a selective filter was added). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("vsf_eval_hard");
  $found = FALSE;
  if ($v) {
    foreach ($v->get("display") as $display) {
      foreach ($display["display_options"]["filters"] ?? [] as $f) {
        if (($f["plugin_id"] ?? "") === "views_selective_filters_filter") { $found = TRUE; }
      }
    }
  }
  print ($found ? "PASS" : "FAIL") . " selective_filter=" . var_export($found, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
