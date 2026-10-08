#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; foreach (["fb_a","fb_b"] as $id) { if ($b = Block::load($id)) { $b->delete(); } }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: fb_a / fb_b removed"
