#!/usr/bin/env bash
# Execution RESET for "restrict the tmui_events vocabulary to the tmui_events_menu menu".
# Creates the tmui_events_menu menu and the tmui_events vocabulary, then STRIPS every
# taxonomy_menu_ui third-party setting from the vocabulary (provider `menu_ui`), so the
# vocabulary falls back to the code defaults (available_menus ['main'], parent 'main:')
# and verify FAILS until the agent configures it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\system\Entity\Menu;
  if (!Menu::load("tmui_events_menu")) {
    Menu::create(["id" => "tmui_events_menu", "label" => "TMUI Events Menu", "description" => "Eval menu"])->save();
  }
  $v = Vocabulary::load("tmui_events") ?: Vocabulary::create(["vid" => "tmui_events", "name" => "TMUI Events"]);
  $v->unsetThirdPartySetting("menu_ui", "available_menus");
  $v->unsetThirdPartySetting("menu_ui", "parent");
  $v->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vocabulary tmui_events has no menu_ui third-party settings; menu tmui_events_menu exists"
