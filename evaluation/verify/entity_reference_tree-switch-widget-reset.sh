#!/usr/bin/env bash
# hard RESET (entity_reference_tree): ensure field_ert_task exists on Article using the DEFAULT
# entity_reference_autocomplete widget so verify FAILS until switched to the tree widget. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ert_task")) {
    FieldStorageConfig::create(["field_name" => "field_ert_task", "entity_type" => "node",
      "type" => "entity_reference", "cardinality" => -1, "settings" => ["target_type" => "node"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ert_task")) {
    FieldConfig::create(["field_name" => "field_ert_task", "entity_type" => "node", "bundle" => "article",
      "label" => "ERT Task", "settings" => ["handler" => "default:node", "handler_settings" => []]])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ert_task", ["type" => "entity_reference_autocomplete", "region" => "content", "weight" => 52])->save();
' >/dev/null 2>&1
echo "reset: field_ert_task uses entity_reference_autocomplete (not the tree widget)"
