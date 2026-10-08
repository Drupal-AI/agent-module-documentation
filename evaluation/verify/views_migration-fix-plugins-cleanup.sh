#!/usr/bin/env bash
# Execution CLEANUP: delete the vm_fix migration. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\migrate_plus\Entity\Migration;
  if ($m = Migration::load("vm_fix")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: migration vm_fix removed"
