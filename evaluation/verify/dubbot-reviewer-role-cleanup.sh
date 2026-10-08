#!/usr/bin/env bash
# Execution CLEANUP: delete the dubbot_reviewer role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("dubbot_reviewer")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role dubbot_reviewer deleted"
