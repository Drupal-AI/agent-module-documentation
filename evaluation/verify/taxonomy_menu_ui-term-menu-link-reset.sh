#!/usr/bin/env bash
# Execution RESET for "add the Human Resources term to the departments menu".
# Creates the tmui_depts_menu menu and the tmui_depts vocabulary already wired up for
# taxonomy_menu_ui (available_menus = [tmui_depts_menu]), then DELETES every term in that
# vocabulary and every link in that menu, so verify FAILS on empty state until the agent
# creates the term and its menu link. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\system\Entity\Menu;
  if (!Menu::load("tmui_depts_menu")) {
    Menu::create(["id" => "tmui_depts_menu", "label" => "TMUI Departments", "description" => "Eval menu"])->save();
  }
  $v = Vocabulary::load("tmui_depts") ?: Vocabulary::create(["vid" => "tmui_depts", "name" => "TMUI Departments"]);
  $v->setThirdPartySetting("menu_ui", "available_menus", ["tmui_depts_menu"]);
  $v->setThirdPartySetting("menu_ui", "parent", "tmui_depts_menu:");
  $v->save();
  $mlc = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($mlc->loadByProperties(["menu_name" => "tmui_depts_menu"]) as $l) { $l->delete(); }
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach ($ts->loadByProperties(["vid" => "tmui_depts"]) as $t) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vocabulary tmui_depts emptied, menu tmui_depts_menu emptied"
