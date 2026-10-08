#!/usr/bin/env bash
# Execution VERIFY: PASS when state key config_normalizer_eval_list holds the normalized form of
# config_normalizer_eval.list, i.e. its 'items' indexed array sorted by value to
# apple,mango,zebra. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("config_normalizer_eval_list");
  $items = is_array($v) ? ($v["items"] ?? $v) : NULL;
  $ok = is_array($items) && array_values($items) === ["apple", "mango", "zebra"];
  print ($ok ? "PASS" : "FAIL") . " items=" . (is_array($items) ? implode(",", $items) : gettype($v)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
