#!/usr/bin/env bash
# Execution RESET for the "build a view using the custom_tag cache plugin" task: delete the
# target view (vcct_hard_report) so it does NOT exist before the agent runs. This guarantees
# verify FAILs on the empty state. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal::entityTypeManager()->getStorage("view")->load("vcct_hard_report")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vcct_hard_report deleted (baseline: does not exist)"
