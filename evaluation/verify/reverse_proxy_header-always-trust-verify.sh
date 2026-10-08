#!/usr/bin/env bash
# Execution VERIFY: PASS when reverse_proxy_header === 'HTTP_X_RPH_TASK2' AND
# reverse_proxy_header_trusted_addresses_ignore === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $h = \Drupal\Core\Site\Settings::get("reverse_proxy_header");
  $i = \Drupal\Core\Site\Settings::get("reverse_proxy_header_trusted_addresses_ignore");
  $ok = ($h === "HTTP_X_RPH_TASK2" && $i === TRUE);
  print ($ok ? "PASS" : "FAIL") . " header=" . var_export($h, TRUE) . " ignore=" . var_export($i, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
