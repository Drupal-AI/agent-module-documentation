#!/usr/bin/env bash
# Execution RESET: ensure role mtr_new does NOT exist, so verify FAILS until the agent creates it
# with the reports permission. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if($r=Role::load("mtr_new")){$r->delete();}' >/dev/null 2>&1
echo "reset: role mtr_new removed (does not exist)"
