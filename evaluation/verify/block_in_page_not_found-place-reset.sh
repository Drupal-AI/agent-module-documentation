#!/usr/bin/env bash
# Execution RESET: ensure block bipnf_task does NOT exist, so verify FAILS on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("bipnf_task")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block bipnf_task absent"
