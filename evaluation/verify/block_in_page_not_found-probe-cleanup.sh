#!/usr/bin/env bash
# Introspection CLEANUP: delete the bipnf_probe block. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("bipnf_probe")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block bipnf_probe removed"
