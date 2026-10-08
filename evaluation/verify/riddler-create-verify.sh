#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled riddle ri_task exists whose solution accepts both "4" and
# "four" (comma-separated) and whose question is set.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("riddle")->load("ri_task");
  if (!$e) { print "FAIL missing\n"; return; }
  $sol = array_map("trim", explode(",", (string) $e->getSolution()));
  $ok = $e->status() && in_array("4", $sol, TRUE) && in_array("four", $sol, TRUE) && trim((string) $e->getQuestion()) !== "";
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($e->status(), TRUE) . " solution=" . var_export($e->getSolution(), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
