#!/usr/bin/env bash
# Execution VERIFY: PASS when purge is time_based, deleting entries older than 90 days.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::config("activities.settings")->get("purge") ?? [];
  $ok = (($p["purge_method"] ?? "") === "time_based") && ((int)($p["time_value"] ?? 0) === 90) && (($p["time_unit"] ?? "") === "days");
  print (($ok) ? "PASS" : "FAIL") . " method=" . var_export($p["purge_method"] ?? NULL, TRUE) . " value=" . var_export($p["time_value"] ?? NULL, TRUE) . " unit=" . var_export($p["time_unit"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
