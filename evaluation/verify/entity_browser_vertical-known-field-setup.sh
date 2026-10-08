#!/usr/bin/env bash
# Introspection SETUP (entity_browser_vertical): create an entity_reference field on Article
# whose Entity Browser widget uses the "entity_browser_vertical_label" display plugin, so an
# inspecting agent can read back which field renders its selection stacked vertically.
# Idempotent. Config save may crash at terminate on this shared site (commerce route rebuild);
# the config still persists and read-only inspection works, so we ignore that. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ebv_known")) {
    FieldStorageConfig::create(["field_name" => "field_ebv_known", "entity_type" => "node",
      "type" => "entity_reference", "settings" => ["target_type" => "node"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ebv_known")) {
    FieldConfig::create(["field_name" => "field_ebv_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Related (vertical)",
      "settings" => ["handler" => "default", "handler_settings" => []]])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ebv_known", ["type" => "entity_browser_entity_reference",
    "region" => "content", "weight" => 50,
    "settings" => ["entity_browser" => "", "field_widget_display" => "entity_browser_vertical_label"]])->save();
' >/dev/null 2>&1 || true
echo "setup: node.article field_ebv_known uses entity_browser widget with field_widget_display=entity_browser_vertical_label"
exit 0
