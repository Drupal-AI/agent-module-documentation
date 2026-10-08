#!/usr/bin/env bash
# hard RESET (entity_reference_tree): ensure field_ert_dialog exists with the tree widget but an
# EMPTY dialog_title so verify FAILS until it is set to 'Select items'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ert_dialog")) {
    FieldStorageConfig::create(["field_name" => "field_ert_dialog", "entity_type" => "node",
      "type" => "entity_reference", "cardinality" => -1, "settings" => ["target_type" => "node"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ert_dialog")) {
    FieldConfig::create(["field_name" => "field_ert_dialog", "entity_type" => "node", "bundle" => "article",
      "label" => "ERT Dialog", "settings" => ["handler" => "default:node", "handler_settings" => []]])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ert_dialog", ["type" => "entity_reference_tree", "region" => "content", "weight" => 53,
    "settings" => ["dialog_title" => ""]])->save();
' >/dev/null 2>&1
echo "reset: field_ert_dialog uses entity_reference_tree with empty dialog_title"
