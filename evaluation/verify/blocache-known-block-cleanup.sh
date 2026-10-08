#!/usr/bin/env bash
# Introspection CLEANUP: delete the blocache_eval block created by setup. Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b = Block::load("blocache_eval")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block blocache_eval removed"
