#!/usr/bin/env bash
# Introspection CLEANUP: delete nthht_on and nthht_off content types. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\node\Entity\NodeType; foreach(["nthht_on","nthht_off"] as $b){ if ($t=NodeType::load($b)) { $t->delete(); } }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: nthht_on, nthht_off removed"
