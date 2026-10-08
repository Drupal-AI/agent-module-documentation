#!/usr/bin/env bash
# Execution VERIFY: PASS when bcc_active is enabled AND bcc_email==ops@example.com.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("commerce_abandoned_carts.settings");
  $a = $c->get("bcc_active"); $e = $c->get("bcc_email");
  $ok = !empty($a) && ($e === "ops@example.com");
  print ($ok ? "PASS" : "FAIL") . " bcc_active=" . var_export($a, TRUE) . " bcc_email=" . var_export($e, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
