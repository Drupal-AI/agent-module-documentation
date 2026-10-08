#!/usr/bin/env bash
# Execution CLEANUP: remove the menu_force_lock content type entirely. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("menu_force_lock")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node type menu_force_lock removed"
