#!/usr/bin/env bash
# Introspection CLEANUP: delete the mlist_lbl block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($b = \Drupal\block\Entity\Block::load("mlist_lbl")) { $b->delete(); }' >/dev/null 2>&1
echo "cleanup: block mlist_lbl removed"
