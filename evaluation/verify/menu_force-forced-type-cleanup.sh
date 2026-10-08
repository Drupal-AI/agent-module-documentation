#!/usr/bin/env bash
# Introspection CLEANUP: remove the menu_force_evt content type created by setup.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("menu_force_evt")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node type menu_force_evt removed"
