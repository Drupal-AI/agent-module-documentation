#!/usr/bin/env bash
# Execution VERIFY: PASS when the node entity type has NO pending/mismatched definition changes (agent
# reconciled it with meaofd). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $has = \Drupal::service("meaofd.fixer")->entityTypeHasChanges("node");
  print ($has ? "FAIL" : "PASS") . " node_has_changes=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
