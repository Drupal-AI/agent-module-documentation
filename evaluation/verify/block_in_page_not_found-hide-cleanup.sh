#!/usr/bin/env bash
# Execution CLEANUP: delete the bipnf_hide block. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("bipnf_hide")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block bipnf_hide removed"
