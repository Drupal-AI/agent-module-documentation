#!/usr/bin/env bash
# Introspection SETUP: create TWO vocabularies — tmui_active, whose taxonomy_menu_ui
# available_menus lists a menu (so the term form shows Menu settings), and tmui_locked,
# whose available_menus is an explicit EMPTY list (which makes
# taxonomy_menu_ui_form_taxonomy_term_form_alter() return early and render nothing).
# The agent must inspect the live vocabulary config to tell which one cannot get menu links.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\system\Entity\Menu;
  if (!Menu::load("tmui_side")) {
    Menu::create(["id" => "tmui_side", "label" => "TMUI Side", "description" => "Eval menu"])->save();
  }
  $a = Vocabulary::load("tmui_active") ?: Vocabulary::create(["vid" => "tmui_active", "name" => "TMUI Active"]);
  $a->setThirdPartySetting("menu_ui", "available_menus", ["tmui_side"]);
  $a->setThirdPartySetting("menu_ui", "parent", "tmui_side:");
  $a->save();
  $b = Vocabulary::load("tmui_locked") ?: Vocabulary::create(["vid" => "tmui_locked", "name" => "TMUI Locked"]);
  $b->setThirdPartySetting("menu_ui", "available_menus", []);
  $b->setThirdPartySetting("menu_ui", "parent", "");
  $b->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tmui_active available_menus=[tmui_side]; tmui_locked available_menus=[]"
