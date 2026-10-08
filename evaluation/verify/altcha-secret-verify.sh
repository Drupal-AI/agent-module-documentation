#!/usr/bin/env bash
# hard VERIFY (altcha): PASS when the ALTCHA self-hosted secret key (State altcha-hmac-key) is present
# and non-empty. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $key = \Drupal::service("altcha.secret_manager")->getSecretKey();
  $ok = (is_string($key) && $key !== "");
  print ($ok ? "PASS" : "FAIL") . " secret_present=" . ($ok ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
