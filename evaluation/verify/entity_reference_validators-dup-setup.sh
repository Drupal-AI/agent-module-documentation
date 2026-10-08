#!/usr/bin/env bash
# Introspection SETUP: two entity_reference fields on Article; field_erv_dup has
# duplicate_reference=true, field_erv_nodup has no validator. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_erv_dup", "field_erv_nodup"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node", "type" => "entity_reference",
        "cardinality" => -1, "settings" => ["target_type" => "node"],
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create([
        "field_name" => $fn, "entity_type" => "node", "bundle" => "article",
        "label" => strtoupper($fn), "settings" => ["handler" => "default:node", "handler_settings" => []],
      ])->save();
    }
  }
  $dup = FieldConfig::loadByName("node", "article", "field_erv_dup");
  $dup->setThirdPartySetting("entity_reference_validators", "duplicate_reference", TRUE);
  $dup->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_erv_dup has duplicate_reference=true; field_erv_nodup has none"
