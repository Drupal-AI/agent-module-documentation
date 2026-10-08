#!/usr/bin/env bash
# Execution RESET: delete role eea_keymanager so verify FAILS until the agent creates it with the
# 'administer easy encryption keys' permission.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if ($r = Role::load("eea_keymanager")) { $r->delete(); }' >/dev/null 2>&1
echo "reset: role eea_keymanager removed"
