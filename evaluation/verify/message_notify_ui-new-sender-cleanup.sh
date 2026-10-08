#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if($r=\Drupal\user\Entity\Role::load("mnui_new_sender")){$r->delete();}' >/dev/null 2>&1
echo "cleanup: mnui_new_sender removed"
