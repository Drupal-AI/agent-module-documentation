#!/usr/bin/env bash
# Execution CLEANUP: delete the namespaced role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("paragraphs_admin_editor")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role paragraphs_admin_editor removed"
