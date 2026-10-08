#!/usr/bin/env bash
# Execution VERIFY: PASS when config_merge_eval_h2_result is the merge {keep:1, mod:4} with the
# 'drop' key removed (an uncustomized removal) and 'mod' updated to 4. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::state()->get("config_merge_eval_h2_result");
  $ok = is_array($r)
    && ($r["keep"] ?? NULL) === 1
    && ($r["mod"] ?? NULL) === 4
    && !array_key_exists("drop", $r);
  print ($ok ? "PASS" : "FAIL") . " result=" . json_encode(is_array($r) ? $r : $r) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
