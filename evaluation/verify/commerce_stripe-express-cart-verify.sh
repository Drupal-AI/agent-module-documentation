#!/usr/bin/env bash
# Execution VERIFY: PASS when csstr_xc gateway has express_checkout.enable_on_cart === TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\commerce_payment\Entity\PaymentGateway;
  $gw = PaymentGateway::load("csstr_xc");
  if (!$gw) { print "FAIL no-gateway\n"; return; }
  $v = $gw->getPlugin()->getConfiguration()["express_checkout"]["enable_on_cart"] ?? NULL;
  print (($v === TRUE) ? "PASS" : "FAIL")." enable_on_cart=".var_export($v, TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
