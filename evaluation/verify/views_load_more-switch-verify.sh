#!/usr/bin/env bash
# Execution VERIFY: PASS when vlm_task's default display pager type is 'load_more'.
# Pure config read (no view save -> no route rebuild). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::config("views.view.vlm_task")->get("display.default.display_options.pager.type");
  print (($t === "load_more") ? "PASS" : "FAIL") . " pager_type=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
