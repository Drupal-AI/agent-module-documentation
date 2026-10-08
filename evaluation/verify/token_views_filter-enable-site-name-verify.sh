#!/usr/bin/env bash
# Execution VERIFY: PASS when tvf_build title filter has use_tokens===true AND value contains
# [site:name].
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::config("views.view.tvf_build")->get("display.default.display_options.filters.title");
  $ut = $f["use_tokens"] ?? NULL;
  $val = is_array($f["value"] ?? NULL) ? implode(",", $f["value"]) : (string) ($f["value"] ?? "");
  $ok = ($ut === TRUE && strpos($val, "[site:name]") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " use_tokens=" . var_export($ut, TRUE) . " value=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
