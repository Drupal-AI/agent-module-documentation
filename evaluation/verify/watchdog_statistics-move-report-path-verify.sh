#!/usr/bin/env bash
# Execution VERIFY: PASS when the watchdog_statistics View page display path is
# 'admin/reports/dblog/stats'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $path = \Drupal::config("views.view.watchdog_statistics")->get("display.page.display_options.path");
  $ok = ($path === "admin/reports/dblog/stats");
  print ($ok ? "PASS" : "FAIL") . " path=" . var_export($path, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
