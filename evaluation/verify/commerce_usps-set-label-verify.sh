#!/usr/bin/env bash
# Execution VERIFY: PASS when cusps_label's plugin configuration rate_label === 'USPS Ground
# Advantage'. Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ms = \Drupal::entityTypeManager()->getStorage("commerce_shipping_method");
  $e = $ms->loadByProperties(["name" => "cusps_label"]);
  $m = $e ? reset($e) : NULL;
  $cfg = $m ? $m->get("plugin")->first()->target_plugin_configuration : [];
  $label = $cfg["rate_label"] ?? NULL;
  print (($label === "USPS Ground Advantage") ? "PASS" : "FAIL") . " rate_label=" . var_export($label, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
