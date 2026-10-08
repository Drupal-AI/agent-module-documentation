#!/usr/bin/env bash
# Live-state verification for the "configure and enable security.txt" execution task.
# PASS when securitytxt.settings is enabled with an email contact, a future-ish expiry_date,
# and a policy URL. Prints PASS/FAIL and exits 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("securitytxt.settings");
  $enabled = (bool) $c->get("enabled");
  $email   = (string) $c->get("contact_email");
  $expiry  = (int) $c->get("expiry_date");
  $policy  = (string) $c->get("policy_url");
  $ok = $enabled
    && $email !== "" && strpos($email, "@") !== FALSE
    && $expiry > 0
    && strpos($policy, "https://") === 0;
  print "\n" . ($ok ? "PASS" : "FAIL")
    . " enabled=" . ($enabled?1:0)
    . " email=" . ($email ?: "-")
    . " expiry=" . $expiry
    . " policy=" . ($policy ?: "-") . "\n";
' 2>/dev/null)
echo "$out" | grep -E '^(PASS|FAIL)'
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
