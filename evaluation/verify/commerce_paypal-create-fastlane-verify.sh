#!/usr/bin/env bash
# HARD execution verify: a commerce_payment_gateway config entity 'fastlane_sandbox' must
# exist, use the Fastlane by PayPal plugin (paypal_fastlane), and be in sandbox mode (test).
# Prints PASS/FAIL, exits 0 (pass) / 1 (fail). Reads config so unrelated deprecation notices
# on this site don't skew the check. Grounded in the config entity only (no live PayPal call).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("commerce_payment.commerce_payment_gateway.fastlane_sandbox");
  $exists = ($c->get("id") === "fastlane_sandbox");
  $plugin = (string) $c->get("plugin");
  $mode = (string) $c->get("configuration.mode");
  $ok = $exists && $plugin === "paypal_fastlane" && $mode === "test";
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($exists?1:0) . " plugin=" . $plugin . " mode=" . $mode . "\n";
' 2>/dev/null | grep -Ev '^\s*(Deprecated|Warning|Notice):' | grep -E '^(PASS|FAIL)')

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
