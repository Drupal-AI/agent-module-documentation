#!/usr/bin/env bash
# Introspection CLEANUP: remove the menu_force_a and menu_force_b content types. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  foreach (["menu_force_a","menu_force_b"] as $id) { if ($t = NodeType::load($id)) { $t->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: menu_force_a and menu_force_b removed"
