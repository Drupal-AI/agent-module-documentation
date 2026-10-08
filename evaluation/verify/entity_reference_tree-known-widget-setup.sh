#!/usr/bin/env bash
# medium SETUP (entity_reference_tree): create entity_reference field field_ert_known on Article and
# set its default form-display widget to entity_reference_tree. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ert_known")) {
    FieldStorageConfig::create(["field_name" => "field_ert_known", "entity_type" => "node",
      "type" => "entity_reference", "cardinality" => -1, "settings" => ["target_type" => "node"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ert_known")) {
    FieldConfig::create(["field_name" => "field_ert_known", "entity_type" => "node", "bundle" => "article",
      "label" => "ERT Known", "settings" => ["handler" => "default:node", "handler_settings" => []]])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ert_known", ["type" => "entity_reference_tree", "region" => "content", "weight" => 50])->save();
' >/dev/null 2>&1
echo "setup: field_ert_known on node.article uses entity_reference_tree widget"
