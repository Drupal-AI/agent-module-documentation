#!/usr/bin/env bash
# Introspection CLEANUP: delete the mm_eval_content block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b = Block::load("mm_eval_content")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mm_eval_content removed"
