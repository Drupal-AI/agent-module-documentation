#!/usr/bin/env bash
# Introspection CLEANUP: delete the mlist_known block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($b = \Drupal\block\Entity\Block::load("mlist_known")) { $b->delete(); }' >/dev/null 2>&1
echo "cleanup: block mlist_known removed"
