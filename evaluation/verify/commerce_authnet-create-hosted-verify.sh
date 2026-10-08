#!/usr/bin/env bash
# Execution VERIFY: PASS when ca_hosted_task is an authorizenet_accept_hosted gateway in live
# mode. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("commerce_payment_gateway")->load("ca_hosted_task");
  $ok = FALSE; $info = "missing";
  if ($e) {
    $plugin = $e->getPluginId();
    $mode = $e->getPluginConfiguration()["mode"] ?? "";
    $ok = ($plugin === "authorizenet_accept_hosted" && $mode === "live");
    $info = "plugin=$plugin mode=" . var_export($mode, TRUE);
  }
  print ($ok ? "PASS" : "FAIL") . " " . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
