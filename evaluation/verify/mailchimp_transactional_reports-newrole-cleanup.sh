#!/usr/bin/env bash
# Execution CLEANUP: delete role mtr_new. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if($r=Role::load("mtr_new")){$r->delete();}' >/dev/null 2>&1
echo "cleanup: role mtr_new removed"
