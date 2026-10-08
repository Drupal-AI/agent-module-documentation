#!/usr/bin/env bash
# Execution VERIFY: PASS when the one-time code is 6 digits and valid for 10 minutes, i.e.
# security_code_length === 6 AND timeouts === 600. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("email_tfa.settings");
  $len = $c->get("security_code_length"); $to = $c->get("timeouts");
  $ok = (((int) $len) === 6 && ((int) $to) === 600);
  print ($ok ? "PASS" : "FAIL") . " security_code_length=" . var_export($len, TRUE) . " timeouts=" . var_export($to, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
