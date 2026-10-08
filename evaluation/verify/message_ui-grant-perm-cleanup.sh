#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\message\Entity\MessageTemplate; use Drupal\user\Entity\Role;
  if($r=Role::load("message_ui_hrole")){$r->delete();}
  if($t=MessageTemplate::load("message_ui_hard")){$t->delete();}
' >/dev/null 2>&1
echo "cleanup: message_ui_hrole + message_ui_hard removed"
