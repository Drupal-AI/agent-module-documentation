#!/usr/bin/env bash
# Execution VERIFY: PASS when the ccp_eval_ship shipping method's base condition operator is OR.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $methods = \Drupal::entityTypeManager()->getStorage("commerce_shipping_method")->loadByProperties(["name" => "ccp_eval_ship"]);
  $m = $methods ? reset($methods) : NULL;
  $op = $m ? $m->getConditionOperator() : NULL;
  $ok = ($op === "OR");
  print ($ok ? "PASS" : "FAIL") . " condition_operator=" . var_export($op, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
