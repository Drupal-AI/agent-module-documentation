#!/usr/bin/env bash
# Execution VERIFY: PASS when the order_fields:checkout pane is placed on a real (non-disabled)
# step of the default checkout flow. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $conf = \Drupal::config("commerce_checkout.commerce_checkout_flow.default")->get("configuration");
  $pane = $conf["panes"]["order_fields:checkout"] ?? NULL;
  $step = $pane["step"] ?? NULL;
  $ok = is_array($pane) && !empty($step) && $step !== "_disabled";
  print ($ok ? "PASS" : "FAIL") . " order_fields:checkout step=" . var_export($step, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
