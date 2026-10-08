#!/usr/bin/env bash
# Introspection CLEANUP: delete the namespaced role created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("paragraphs_admin_viewer")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role paragraphs_admin_viewer removed"
