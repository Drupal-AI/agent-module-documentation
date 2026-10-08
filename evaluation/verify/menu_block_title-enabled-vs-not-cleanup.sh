#!/usr/bin/env bash
# Introspection CLEANUP: delete mbt_on and mbt_off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; foreach (["mbt_on","mbt_off"] as $id) { if ($b = Block::load($id)) { $b->delete(); } }' >/dev/null 2>&1
echo "cleanup: mbt_on, mbt_off removed"
