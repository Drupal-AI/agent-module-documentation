#!/usr/bin/env bash
# Execution VERIFY: PASS when the inactive state wc_wf_old has been removed (config gone) while the
# workflow wc_wf still exists. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $all = \Drupal::configFactory()->listAll("");
  $old = in_array("workflow.state.wc_wf_old", $all, TRUE);
  $wf = in_array("workflow.workflow.wc_wf", $all, TRUE);
  $ok = !$old && $wf;
  print ($ok ? "PASS" : "FAIL") . " wc_wf_old_exists=" . ($old ? "1" : "0") . " wc_wf_exists=" . ($wf ? "1" : "0") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
