#!/usr/bin/env bash
# Introspection CLEANUP: delete the lbcs_editor role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($r = \Drupal\user\Entity\Role::load("lbcs_editor")) { $r->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role lbcs_editor removed"
