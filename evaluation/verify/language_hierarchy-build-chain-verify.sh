#!/usr/bin/env bash
# Execution VERIFY: PASS when the resolved fallback candidates for lhc include BOTH lhm and lhp
# (i.e. the chain lhc -> lhm -> lhp is in effect through the live language manager).
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cands = array_keys(\Drupal::languageManager()->getFallbackCandidates(["langcode" => "lhc", "operation" => "eval"]));
  $ok = (in_array("lhm", $cands, TRUE) && in_array("lhp", $cands, TRUE));
  print ($ok ? "PASS" : "FAIL") . " candidates=" . implode(",", $cands) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
