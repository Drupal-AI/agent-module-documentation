#!/usr/bin/env bash
# Introspection SETUP: create a dedicated vocabulary tmui_products and a menu tmui_catalog,
# then use taxonomy_menu_ui's per-vocabulary storage — third-party settings under the
# `menu_ui` provider — to allow that menu (and only it) for the vocabulary, with a known
# default parent. The agent must read taxonomy.vocabulary.tmui_products to answer.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\system\Entity\Menu;
  if (!Menu::load("tmui_catalog")) {
    Menu::create(["id" => "tmui_catalog", "label" => "TMUI Catalog", "description" => "Eval menu"])->save();
  }
  $v = Vocabulary::load("tmui_products");
  if (!$v) {
    $v = Vocabulary::create(["vid" => "tmui_products", "name" => "TMUI Products"]);
  }
  $v->setThirdPartySetting("menu_ui", "available_menus", ["tmui_catalog"]);
  $v->setThirdPartySetting("menu_ui", "parent", "tmui_catalog:");
  $v->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vocabulary tmui_products third_party_settings.menu_ui.available_menus=[tmui_catalog], parent=tmui_catalog:"
