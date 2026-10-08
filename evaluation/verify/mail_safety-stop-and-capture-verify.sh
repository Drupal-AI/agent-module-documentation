#!/usr/bin/env bash
# Execution VERIFY: PASS when mail_safety stops outgoing mail (enabled) AND captures to the
# dashboard (send_mail_to_dashboard). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("mail_safety.settings");
  $ok = ($c->get("enabled") == TRUE) && ($c->get("send_mail_to_dashboard") == TRUE);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($c->get("enabled"), TRUE) . " dashboard=" . var_export($c->get("send_mail_to_dashboard"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
