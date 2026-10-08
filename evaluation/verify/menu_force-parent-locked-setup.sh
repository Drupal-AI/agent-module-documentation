#!/usr/bin/env bash
# Introspection SETUP: create two content types that both force menu placement, but only
# menu_force_b also locks the default parent item (menu_force_parent=true). Lets an agent
# tell which one locks the parent. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $a = NodeType::load("menu_force_a") ?: NodeType::create(["type"=>"menu_force_a","name"=>"Menu Force A"]);
  $a->setThirdPartySetting("menu_force", "menu_force", TRUE);
  $a->setThirdPartySetting("menu_force", "menu_force_parent", FALSE);
  $a->save();
  $b = NodeType::load("menu_force_b") ?: NodeType::create(["type"=>"menu_force_b","name"=>"Menu Force B"]);
  $b->setThirdPartySetting("menu_force", "menu_force", TRUE);
  $b->setThirdPartySetting("menu_force", "menu_force_parent", TRUE);
  $b->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: menu_force_a (parent unlocked) and menu_force_b (parent locked) created"
