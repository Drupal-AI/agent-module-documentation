#!/usr/bin/env bash
# Execution VERIFY: PASS when state key config_normalizer_eval_sorted holds the normalized
# (key-sorted) form of config_normalizer_eval.data, i.e. an array whose keys are exactly
# apple,mango,zebra in that order. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("config_normalizer_eval_sorted");
  $ok = is_array($v) && array_keys($v) === ["apple", "mango", "zebra"];
  print ($ok ? "PASS" : "FAIL") . " keys=" . (is_array($v) ? implode(",", array_keys($v)) : gettype($v)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
