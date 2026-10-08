#!/usr/bin/env bash
# Execution VERIFY: PASS when excluded_paths excludes the admin area (contains /admin and /admin/*).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("single_language_url_prefix.settings")->get("excluded_paths");
  $ok = (strpos($v, "/admin/*") !== FALSE) && (preg_match("#(^|\n)/admin(\n|$)#", $v) === 1);
  print ($ok ? "PASS" : "FAIL") . " excluded_paths=" . str_replace("\n","\\n",var_export($v, TRUE)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
