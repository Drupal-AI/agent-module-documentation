#!/usr/bin/env bash
# Introspection CLEANUP: remove block ssf_medium2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("ssf_medium2")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block ssf_medium2 removed"
