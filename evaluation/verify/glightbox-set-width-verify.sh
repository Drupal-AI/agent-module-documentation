#!/usr/bin/env bash
# Execution VERIFY: PASS when glightbox.settings custom.width == 75%. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$w=\Drupal::config("glightbox.settings")->get("custom.width"); print((($w==="75%")?"PASS":"FAIL")." width=".var_export($w,TRUE));' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
