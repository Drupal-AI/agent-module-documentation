#!/usr/bin/env bash
# Introspection CLEANUP: delete role u404_editor.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if ($r = Role::load("u404_editor")) { $r->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role u404_editor removed"
