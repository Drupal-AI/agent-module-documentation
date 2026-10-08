#!/usr/bin/env bash
# Execution CLEANUP: delete role csu_clerk. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if($r=Role::load("csu_clerk")){$r->delete();}' >/dev/null 2>&1
echo "cleanup: role csu_clerk removed"
