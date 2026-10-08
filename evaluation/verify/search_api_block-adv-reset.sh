#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure block sab_adv does NOT exist. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($b = \Drupal\block\Entity\Block::load("sab_adv")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block.block.sab_adv absent"
