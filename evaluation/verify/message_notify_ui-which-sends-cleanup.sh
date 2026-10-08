#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach(["mnui_yes","mnui_no"] as $id){if($r=\Drupal\user\Entity\Role::load($id)){$r->delete();}}' >/dev/null 2>&1
echo "cleanup: mnui_yes + mnui_no removed"
