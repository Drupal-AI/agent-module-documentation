#!/usr/bin/env bash
# Execution VERIFY: PASS when a payment gateway csq_build exists, uses the square plugin,
# and is in test (Sandbox) mode.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\commerce_payment\Entity\PaymentGateway;
  $g = PaymentGateway::load("csq_build");
  $plugin = $g ? $g->get("plugin") : "none";
  $mode = $g ? ($g->get("configuration")["mode"] ?? "?") : "?";
  $ok = ($g && $plugin === "square" && $mode === "test");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " mode=" . $mode . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
