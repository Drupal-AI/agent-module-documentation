#!/usr/bin/env bash
# Execution RESET: ensure reference type 'bibcite_task_type' does NOT exist so verify FAILS until
# the agent creates it. Running reset again after the task = cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\bibcite_entity\Entity\ReferenceType;
  if ($t = ReferenceType::load("bibcite_task_type")) { $t->delete(); }
' >/dev/null 2>&1 || true
echo "reset: bibcite_reference_type bibcite_task_type absent"
