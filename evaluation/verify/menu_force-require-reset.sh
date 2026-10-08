#!/usr/bin/env bash
# Execution RESET: ensure content type menu_force_task exists with Menu Force OFF, so verify
# FAILS until the agent turns it on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("menu_force_task") ?: NodeType::create(["type"=>"menu_force_task","name"=>"Menu Force Task"]);
  $t->setThirdPartySetting("menu_force", "menu_force", FALSE);
  $t->setThirdPartySetting("menu_force", "menu_force_parent", FALSE);
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node type menu_force_task present with menu_force=FALSE"
