#!/usr/bin/env bash
# Execution RESET: ensure vocabulary mfx_task exists with Menu Force (taxonomy) OFF, so verify
# FAILS until the agent turns it on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("mfx_task") ?: Vocabulary::create(["vid"=>"mfx_task","name"=>"MFX Task"]);
  $v->setThirdPartySetting("menu_force_taxonomy_menu_ui", "menu_force_taxonomy_menu_ui", FALSE);
  $v->setThirdPartySetting("menu_force_taxonomy_menu_ui", "menu_force_taxonomy_menu_ui_parent", FALSE);
  $v->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vocabulary mfx_task present with menu_force_taxonomy_menu_ui=FALSE"
