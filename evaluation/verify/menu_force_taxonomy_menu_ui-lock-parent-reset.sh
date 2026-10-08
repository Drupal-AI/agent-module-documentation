#!/usr/bin/env bash
# Execution RESET: ensure vocabulary mfx_lock exists with BOTH taxonomy Menu Force flags OFF,
# so verify FAILS until the agent enables both. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("mfx_lock") ?: Vocabulary::create(["vid"=>"mfx_lock","name"=>"MFX Lock"]);
  $v->setThirdPartySetting("menu_force_taxonomy_menu_ui", "menu_force_taxonomy_menu_ui", FALSE);
  $v->setThirdPartySetting("menu_force_taxonomy_menu_ui", "menu_force_taxonomy_menu_ui_parent", FALSE);
  $v->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vocabulary mfx_lock present with both flags FALSE"
