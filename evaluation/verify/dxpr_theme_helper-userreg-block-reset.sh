#!/usr/bin/env bash
# Execution RESET: ensure the block dth_userreg_task does NOT exist, so verify FAILS until the
# agent places the DXPR Theme Helper user-registration block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b = Block::load("dth_userreg_task")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block dth_userreg_task absent"
