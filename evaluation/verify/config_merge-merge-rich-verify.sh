#!/usr/bin/env bash
# Execution VERIFY: PASS when config_merge_eval_h1_result holds the correct three-way merge:
# slogan=new (update), color=green (customization retained), added=yes (addition),
# tags=[a,b,c] (indexed substitute). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::state()->get("config_merge_eval_h1_result");
  $ok = is_array($r)
    && ($r["slogan"] ?? NULL) === "new"
    && ($r["color"] ?? NULL) === "green"
    && ($r["added"] ?? NULL) === "yes"
    && isset($r["tags"]) && is_array($r["tags"]) && array_values($r["tags"]) === ["a", "b", "c"];
  print ($ok ? "PASS" : "FAIL") . " result=" . json_encode(is_array($r) ? $r : $r) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
