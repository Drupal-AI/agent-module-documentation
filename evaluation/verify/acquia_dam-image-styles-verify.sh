#!/usr/bin/env bash
# Execution VERIFY: PASS when acquia_dam.settings allowed_image_styles restricts DAM image
# rendering to exactly the core styles 'thumbnail' and 'large' (order-insensitive).
# Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::config("acquia_dam.settings")->get("allowed_image_styles") ?: [];
  sort($s);
  $ok = ($s === ["large", "thumbnail"]);
  print ($ok ? "PASS" : "FAIL") . " allowed_image_styles=" . json_encode(array_values($s)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
