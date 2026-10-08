#!/usr/bin/env bash
# Execution VERIFY: PASS when facebook_pixel_commerce is installed AND the default Commerce
# checkout flow contains the facebook_checkout pane on the order_information step.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $installed = \Drupal::moduleHandler()->moduleExists("facebook_pixel_commerce");
  $flow = \Drupal::entityTypeManager()->getStorage("commerce_checkout_flow")->load("default");
  $panes = $flow ? ($flow->get("configuration")["panes"] ?? []) : [];
  $pane = $panes["facebook_checkout"] ?? NULL;
  $step = $pane["step"] ?? "none";
  $ok = $installed && is_array($pane) && ($step === "order_information");
  print ($ok ? "PASS" : "FAIL") . " module=" . ($installed ? "installed" : "no")
    . " pane=" . (is_array($pane) ? "present" : "absent")
    . " step=" . $step . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
