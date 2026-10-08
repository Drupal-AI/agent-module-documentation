#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'pagehead' (noimageindex meta tag) image-search option is truthy.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::config("copyprevention.settings")->get("copyprevention_images_search");
  $v = is_array($s) ? ($s["pagehead"] ?? NULL) : NULL;
  $ok = !empty($v);
  print ($ok ? "PASS" : "FAIL") . " pagehead=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
