#!/usr/bin/env bash
# CLEANUP: delete Message template 'message_ui_eval'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\message\Entity\MessageTemplate; if($t=MessageTemplate::load("message_ui_eval")){$t->delete();}' >/dev/null 2>&1
echo "cleanup: message_ui_eval removed"
