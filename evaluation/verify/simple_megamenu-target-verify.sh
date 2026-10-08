#!/usr/bin/env bash
# Execution VERIFY: PASS when the smm_task bundle targets the 'main' menu, i.e. its targetMenu
# contains 'main'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal\simple_megamenu\Entity\SimpleMegaMenuType::load("smm_task");
  $tm = $t ? array_filter($t->getTargetMenu()) : [];
  $ok = in_array("main", array_values($tm), TRUE) || isset($tm["main"]);
  print ($ok ? "PASS" : "FAIL") . " targetMenu=" . json_encode($tm) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
