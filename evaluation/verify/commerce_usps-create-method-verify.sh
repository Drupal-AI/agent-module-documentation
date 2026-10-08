#!/usr/bin/env bash
# Execution VERIFY: PASS when a commerce_shipping_method named cusps_task exists using plugin
# 'usps'. Read-only. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ms = \Drupal::entityTypeManager()->getStorage("commerce_shipping_method");
  $e = $ms->loadByProperties(["name" => "cusps_task"]);
  $m = $e ? reset($e) : NULL;
  $pid = $m ? $m->get("plugin")->first()->target_plugin_id : NULL;
  print (($pid === "usps") ? "PASS" : "FAIL") . " plugin=" . var_export($pid, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
