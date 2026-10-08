#!/usr/bin/env bash
# Execution VERIFY: PASS when the vrd_cache view's default display uses the
# views_remote_data_time cache plugin. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::config("views.view.vrd_cache")->get("display.default.display_options.cache.type");
  $ok = ($t === "views_remote_data_time");
  print ($ok ? "PASS" : "FAIL") . " cache.type=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
