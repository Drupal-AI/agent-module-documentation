#!/usr/bin/env bash
# Execution VERIFY: PASS when the ccp_eval_ship shipping method's conditions include a
# commerce_conditions_plus operator condition (and/or operator). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $methods = \Drupal::entityTypeManager()->getStorage("commerce_shipping_method")->loadByProperties(["name" => "ccp_eval_ship"]);
  $m = $methods ? reset($methods) : NULL;
  $vals = $m ? $m->get("conditions")->getValue() : [];
  $found = "";
  foreach ($vals as $v) {
    $pid = $v["target_plugin_id"] ?? "";
    if (strpos($pid, "commerce_conditions_plus_") === 0) { $found = $pid; break; }
  }
  $ok = ($found !== "");
  print ($ok ? "PASS" : "FAIL") . " operator_condition=" . ($found ?: "none") . " total_conditions=" . count($vals) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
