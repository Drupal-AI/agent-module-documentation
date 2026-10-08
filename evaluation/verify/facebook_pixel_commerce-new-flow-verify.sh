#!/usr/bin/env bash
# Execution VERIFY: PASS when a commerce_checkout_flow config entity fbpc_eval_flow exists
# and carries the facebook_pixel_commerce facebook_checkout pane on the order_information
# step. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $flow = \Drupal::entityTypeManager()->getStorage("commerce_checkout_flow")->load("fbpc_eval_flow");
  $panes = $flow ? ($flow->get("configuration")["panes"] ?? []) : [];
  $pane = $panes["facebook_checkout"] ?? NULL;
  $step = $pane["step"] ?? "none";
  $ok = $flow && is_array($pane) && ($step === "order_information");
  print ($ok ? "PASS" : "FAIL") . " flow=" . ($flow ? "exists" : "missing")
    . " pane=" . (is_array($pane) ? "present" : "absent")
    . " step=" . $step . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
