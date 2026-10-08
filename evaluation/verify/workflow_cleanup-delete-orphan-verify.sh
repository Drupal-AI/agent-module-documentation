#!/usr/bin/env bash
# Execution VERIFY: PASS when the orphaned state config workflow.state.wc_orphan no longer exists.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $exists = in_array("workflow.state.wc_orphan", \Drupal::configFactory()->listAll("workflow.state."), TRUE);
  print ($exists ? "FAIL" : "PASS") . " wc_orphan_exists=" . ($exists ? "1" : "0") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
