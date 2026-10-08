#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if($r=Role::load("sfmu_task")){$r->delete();}' >/dev/null 2>&1
echo "cleanup: role sfmu_task removed"
