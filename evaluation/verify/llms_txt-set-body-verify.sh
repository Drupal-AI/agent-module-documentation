#!/usr/bin/env bash
# Execution VERIFY: PASS when llms_txt.settings.content contains the heading '# Acme AI Index'.
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $content = (string) \Drupal::config("llms_txt.settings")->get("content");
  $ok = strpos($content, "# Acme AI Index") !== FALSE;
  print ($ok ? "PASS" : "FAIL") . " has_heading=" . ($ok?"yes":"no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
