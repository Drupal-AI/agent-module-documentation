#!/usr/bin/env bash
# Introspection SETUP: create two vocabularies that both force term menu placement, but only
# mfx_b also locks the default parent item. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $a = Vocabulary::load("mfx_a") ?: Vocabulary::create(["vid"=>"mfx_a","name"=>"MFX A"]);
  $a->setThirdPartySetting("menu_force_taxonomy_menu_ui", "menu_force_taxonomy_menu_ui", TRUE);
  $a->setThirdPartySetting("menu_force_taxonomy_menu_ui", "menu_force_taxonomy_menu_ui_parent", FALSE);
  $a->save();
  $b = Vocabulary::load("mfx_b") ?: Vocabulary::create(["vid"=>"mfx_b","name"=>"MFX B"]);
  $b->setThirdPartySetting("menu_force_taxonomy_menu_ui", "menu_force_taxonomy_menu_ui", TRUE);
  $b->setThirdPartySetting("menu_force_taxonomy_menu_ui", "menu_force_taxonomy_menu_ui_parent", TRUE);
  $b->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mfx_a (parent unlocked) and mfx_b (parent locked) created"
