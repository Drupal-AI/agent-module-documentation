#!/usr/bin/env bash
# Execution VERIFY for "turn on the global 'show rename link on all file fields' setting".
# PASS when file_rename.settings:always_show_widget_link is truthy (1). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("file_rename.settings")->get("always_show_widget_link");
  $ok = !empty($v);
  print ($ok ? "PASS" : "FAIL") . " always_show_widget_link=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
