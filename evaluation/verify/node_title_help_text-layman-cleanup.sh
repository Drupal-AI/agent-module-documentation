#!/usr/bin/env bash
# Execution CLEANUP: delete the nthht_recipe content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\node\Entity\NodeType; if ($t=NodeType::load("nthht_recipe")) { $t->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: nthht_recipe removed"
