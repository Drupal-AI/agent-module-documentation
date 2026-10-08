#!/usr/bin/env bash
# Execution RESET: ensure content type menu_force_lock exists with BOTH Menu Force flags OFF,
# so verify FAILS until the agent enables both menu_force and menu_force_parent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("menu_force_lock") ?: NodeType::create(["type"=>"menu_force_lock","name"=>"Menu Force Lock"]);
  $t->setThirdPartySetting("menu_force", "menu_force", FALSE);
  $t->setThirdPartySetting("menu_force", "menu_force_parent", FALSE);
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node type menu_force_lock present with both flags FALSE"
