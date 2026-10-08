#!/usr/bin/env bash
# Execution VERIFY (insert_colorbox): PASS when insert_colorbox.config gallery === 'post'
# (per-post gallery grouping). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $g = \Drupal::config("insert_colorbox.config")->get("gallery");
  $ok = ($g === "post");
  print ($ok ? "PASS" : "FAIL") . " gallery=" . var_export($g, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
