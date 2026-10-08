#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\message\Entity\MessageTemplate; if($t=MessageTemplate::load("message_ui_view")){$t->delete();}' >/dev/null 2>&1
echo "cleanup: message_ui_view removed"
