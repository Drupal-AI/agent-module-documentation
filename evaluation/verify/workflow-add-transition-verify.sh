#!/usr/bin/env bash
# Execution VERIFY: PASS when the wf_trans workflow has a config transition from wf_trans_published
# to wf_trans_archived. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\workflow\Entity\WorkflowConfigTransition;
  $found = FALSE;
  foreach (WorkflowConfigTransition::loadMultiple() as $t) {
    if ($t->getWorkflowId() === "wf_trans" && $t->getFromSid() === "wf_trans_published" && $t->getToSid() === "wf_trans_archived") { $found = TRUE; break; }
  }
  print ($found ? "PASS" : "FAIL") . " published_to_archived=" . ($found ? "1" : "0") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
