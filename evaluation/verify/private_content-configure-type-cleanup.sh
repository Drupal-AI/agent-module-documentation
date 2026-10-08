#!/usr/bin/env bash
# Execution CLEANUP: delete the pc_task content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\node\Entity\NodeType; if ($t = NodeType::load("pc_task")) { $t->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: content type pc_task removed"
