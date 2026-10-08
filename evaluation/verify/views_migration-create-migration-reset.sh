#!/usr/bin/env bash
# Execution RESET: ensure the migration vm_task does NOT exist, so verify FAILS until the agent
# creates it in the views_migration group with the module's source/destination. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\migrate_plus\Entity\Migration;
  if ($m = Migration::load("vm_task")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: migration vm_task absent"
