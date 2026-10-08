#!/usr/bin/env bash
# Introspection SETUP (field_menu): create a field_menu ("Menu item") field
# field_fmenu_known on Article, restricted via field settings to the 'main' menu only, and
# place its widget on the default form display so an inspecting agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fmenu_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_fmenu_known", "entity_type" => "node", "type" => "field_menu",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fmenu_known")) {
    FieldConfig::create([
      "field_name" => "field_fmenu_known", "entity_type" => "node", "bundle" => "article",
      "label" => "Known Sitemap",
      "settings" => ["menu_type_checkbox" => ["main" => "main"], "menu_type_checkbox_negate" => FALSE],
    ])->save();
  }
  else {
    $fc = FieldConfig::loadByName("node", "article", "field_fmenu_known");
    $fc->setSettings(["menu_type_checkbox" => ["main" => "main"], "menu_type_checkbox_negate" => FALSE])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default")
    ->setComponent("field_fmenu_known", ["type" => "field_menu_tree_widget", "weight" => 50, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_fmenu_known (field_menu) restricted to menu 'main'"
