#!/usr/bin/env bash
# Execution VERIFY (insert_colorbox): PASS when insert_colorbox.config style === 'large' (the
# image style shown inside the colorbox). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $style = (string) (\Drupal::config("insert_colorbox.config")->get("style") ?? "");
  $ok = ($style === "large");
  print ($ok ? "PASS" : "FAIL") . " style=" . var_export($style, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
