#!/usr/bin/env bash
# Execution VERIFY: PASS when splide.settings sitewide is truthy (Splide assets loaded site-wide). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$v=\Drupal::config("splide.settings")->get("sitewide"); $b=filter_var($v,FILTER_VALIDATE_BOOLEAN); print(($b?"PASS":"FAIL")." sitewide=".var_export($v,TRUE));' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
