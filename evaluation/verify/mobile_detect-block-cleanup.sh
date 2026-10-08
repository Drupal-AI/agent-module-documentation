#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b = Block::load("mdeval_known")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block mdeval_known removed"
