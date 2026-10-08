#!/usr/bin/env bash
# Introspection SETUP: create an entity_reference field field_erv_known on Article (targeting
# nodes) and turn on entity_reference_validators "circular_reference". Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_erv_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_erv_known", "entity_type" => "node",
      "type" => "entity_reference", "settings" => ["target_type" => "node"],
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_erv_known");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_erv_known", "entity_type" => "node", "bundle" => "article",
      "label" => "ERV Known", "settings" => ["handler" => "default:node", "handler_settings" => []],
    ]);
  }
  $fc->setThirdPartySetting("entity_reference_validators", "circular_reference", TRUE);
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_erv_known has entity_reference_validators.circular_reference=true"
