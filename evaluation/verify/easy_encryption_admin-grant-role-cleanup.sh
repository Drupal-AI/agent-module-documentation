#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if ($r = Role::load("eea_keymanager")) { $r->delete(); }' >/dev/null 2>&1
echo "cleanup: role eea_keymanager removed"
