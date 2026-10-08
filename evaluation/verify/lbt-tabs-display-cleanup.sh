#!/usr/bin/env bash
# Introspection CLEANUP: delete the lbt_demo content type (drops its view displays). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("lbt_demo")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: lbt_demo content type removed"
