#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\node\Entity\NodeType; if ($t = NodeType::load("tocjs_page")) { $t->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: content type tocjs_page removed"
