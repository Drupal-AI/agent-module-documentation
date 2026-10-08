#!/usr/bin/env bash
# Introspection CLEANUP: delete the libraries_ui_auditor role. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("libraries_ui_auditor")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role libraries_ui_auditor removed"
