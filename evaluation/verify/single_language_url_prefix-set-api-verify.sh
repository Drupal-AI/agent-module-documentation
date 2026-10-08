#!/usr/bin/env bash
# Execution VERIFY: PASS when excluded_paths excludes /api/* from the language prefix. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("single_language_url_prefix.settings")->get("excluded_paths");
  $ok = (strpos($v, "/api/*") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " excluded_paths=" . str_replace("\n","\\n",var_export($v, TRUE)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
