#!/usr/bin/env bash
# Execution VERIFY: PASS when a commerce_payment_gateway 'csstr_hard' exists using plugin
# stripe_payment_element with publishable_key 'pk_test_HARD'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\commerce_payment\Entity\PaymentGateway;
  $gw = PaymentGateway::load("csstr_hard");
  if (!$gw) { print "FAIL no-gateway\n"; return; }
  $plugin = $gw->getPluginId();
  $pk = $gw->getPlugin()->getConfiguration()["publishable_key"] ?? "";
  $ok = ($plugin === "stripe_payment_element" && $pk === "pk_test_HARD");
  print ($ok ? "PASS" : "FAIL")." plugin=".$plugin." pk=".$pk."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
