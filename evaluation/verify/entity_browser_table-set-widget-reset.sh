#!/usr/bin/env bash
# Execution RESET: ensure an entity_reference field field_ebt_task exists on Article whose
# form-display widget is the plain autocomplete (NOT the table widget), so verify FAILS until
# the agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ebt_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_ebt_task", "entity_type" => "node", "type" => "entity_reference",
      "cardinality" => -1, "settings" => ["target_type" => "node"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ebt_task")) {
    FieldConfig::create([
      "field_name" => "field_ebt_task", "entity_type" => "node", "bundle" => "article",
      "label" => "EBT Task", "settings" => ["handler" => "default:node"],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ebt_task", [
    "type" => "entity_reference_autocomplete", "weight" => 61, "region" => "content", "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ebt_task present with entity_reference_autocomplete widget"
