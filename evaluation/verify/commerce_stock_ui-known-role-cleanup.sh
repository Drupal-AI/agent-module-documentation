#!/usr/bin/env bash
# Introspection CLEANUP: delete the csu_known role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if($r=Role::load("csu_known")){$r->delete();}' >/dev/null 2>&1
echo "cleanup: role csu_known removed"
