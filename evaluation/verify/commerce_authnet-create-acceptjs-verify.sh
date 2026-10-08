#!/usr/bin/env bash
# Execution VERIFY: PASS when ca_task is an authorizenet_acceptjs gateway in test mode with
# non-empty api_login, transaction_key and client_key. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("commerce_payment_gateway")->load("ca_task");
  $ok = FALSE; $info = "missing";
  if ($e) {
    $plugin = $e->getPluginId();
    $c = $e->getPluginConfiguration();
    $mode = $c["mode"] ?? "";
    $creds = !empty($c["api_login"]) && !empty($c["transaction_key"]) && !empty($c["client_key"]);
    $ok = ($plugin === "authorizenet_acceptjs" && $mode === "test" && $creds);
    $info = "plugin=$plugin mode=" . var_export($mode, TRUE) . " creds_set=" . var_export($creds, TRUE);
  }
  print ($ok ? "PASS" : "FAIL") . " " . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
