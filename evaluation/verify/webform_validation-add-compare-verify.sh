#!/usr/bin/env bash
# Execution VERIFY for "make wfv_end greater than wfv_start on webform wfv_range".
# PASS when wfv_end has #compare__enabled truthy, #compare__component == wfv_start, and
# #compare__operator == '>'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("wfv_range");
  $el = $w ? $w->getElementDecoded("wfv_end") : NULL;
  $on = !empty($el["#compare__enabled"]);
  $comp = $el["#compare__component"] ?? "";
  $op = $el["#compare__operator"] ?? "";
  $ok = ($on && $comp === "wfv_start" && $op === ">");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($on, TRUE) . " component=" . $comp . " operator=" . $op . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
