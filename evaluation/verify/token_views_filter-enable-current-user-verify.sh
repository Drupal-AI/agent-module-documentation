#!/usr/bin/env bash
# Execution VERIFY: PASS when tvf_task title filter has use_tokens===true AND value contains
# [current-user:uid].
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::config("views.view.tvf_task")->get("display.default.display_options.filters.title");
  $ut = $f["use_tokens"] ?? NULL;
  $val = is_array($f["value"] ?? NULL) ? implode(",", $f["value"]) : (string) ($f["value"] ?? "");
  $ok = ($ut === TRUE && strpos($val, "[current-user:uid]") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " use_tokens=" . var_export($ut, TRUE) . " value=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
