#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled commerce_pricelist named cpl_task_list exists. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("commerce_pricelist")->loadByProperties(["name"=>"cpl_task_list"]);
  $ok = !empty($e);
  print ($ok ? "PASS" : "FAIL") . " matches=" . count($e) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
