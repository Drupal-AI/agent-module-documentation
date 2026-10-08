#!/usr/bin/env bash
# Introspection CLEANUP: delete the ba_known_editor role. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("ba_known_editor")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role ba_known_editor removed"
