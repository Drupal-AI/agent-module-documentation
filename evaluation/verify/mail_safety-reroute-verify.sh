#!/usr/bin/env bash
# Execution VERIFY: PASS when Mail Safety reroutes outgoing mail to safety-inbox@example.test
# (send_mail_to_default_mail on AND default_mail_address matches). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("mail_safety.settings");
  $ok = ($c->get("send_mail_to_default_mail") == TRUE) && ($c->get("default_mail_address") === "safety-inbox@example.test");
  print ($ok ? "PASS" : "FAIL") . " reroute=" . var_export($c->get("send_mail_to_default_mail"), TRUE) . " addr=" . var_export($c->get("default_mail_address"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
