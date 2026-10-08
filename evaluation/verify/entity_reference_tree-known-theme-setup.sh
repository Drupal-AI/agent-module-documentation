#!/usr/bin/env bash
# medium SETUP (entity_reference_tree): create field_ert_theme on Article with the tree widget and
# jsTree theme 'default-dark'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ert_theme")) {
    FieldStorageConfig::create(["field_name" => "field_ert_theme", "entity_type" => "node",
      "type" => "entity_reference", "cardinality" => -1, "settings" => ["target_type" => "node"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ert_theme")) {
    FieldConfig::create(["field_name" => "field_ert_theme", "entity_type" => "node", "bundle" => "article",
      "label" => "ERT Theme", "settings" => ["handler" => "default:node", "handler_settings" => []]])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ert_theme", ["type" => "entity_reference_tree", "region" => "content", "weight" => 51,
    "settings" => ["theme" => "default-dark"]])->save();
' >/dev/null 2>&1
echo "setup: field_ert_theme uses entity_reference_tree widget with theme=default-dark"
