#!/usr/bin/env bash
# Introspection SETUP: create vocabulary mfx_evt and turn Menu Force (taxonomy) ON for it, so
# an inspecting agent can read back which vocabulary forces menu placement. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("mfx_evt") ?: Vocabulary::create(["vid"=>"mfx_evt","name"=>"MFX Event"]);
  $v->setThirdPartySetting("menu_force_taxonomy_menu_ui", "menu_force_taxonomy_menu_ui", TRUE);
  $v->setThirdPartySetting("menu_force_taxonomy_menu_ui", "menu_force_taxonomy_menu_ui_parent", FALSE);
  $v->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vocabulary mfx_evt has menu_force_taxonomy_menu_ui=true"
