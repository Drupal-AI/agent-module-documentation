#!/usr/bin/env bash
# Introspection SETUP: create a content type menu_force_evt and turn Menu Force ON for it
# (third_party_settings.menu_force.menu_force=true), so an inspecting agent can read back
# which content type forces menu placement. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("menu_force_evt") ?: NodeType::create(["type"=>"menu_force_evt","name"=>"Menu Force Event"]);
  $t->setThirdPartySetting("menu_force", "menu_force", TRUE);
  $t->setThirdPartySetting("menu_force", "menu_force_parent", FALSE);
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node type menu_force_evt has menu_force.menu_force=true"
