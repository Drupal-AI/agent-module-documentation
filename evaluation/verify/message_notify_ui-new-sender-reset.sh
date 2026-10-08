#!/usr/bin/env bash
# Execution RESET: ensure role 'mnui_new_sender' does NOT exist. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if($r=\Drupal\user\Entity\Role::load("mnui_new_sender")){$r->delete();}' >/dev/null 2>&1
echo "reset: role mnui_new_sender absent"
