#!/usr/bin/env bash
# Execution RESET: ensure role csu_clerk does NOT exist, so verify FAILS until the agent creates
# it with the transaction-form permission. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if($r=Role::load("csu_clerk")){$r->delete();}' >/dev/null 2>&1
echo "reset: role csu_clerk absent"
