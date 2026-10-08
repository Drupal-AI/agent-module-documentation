#!/usr/bin/env bash
# Introspection CLEANUP: delete the vm_known migration. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\migrate_plus\Entity\Migration;
  if ($m = Migration::load("vm_known")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: migration vm_known removed"
