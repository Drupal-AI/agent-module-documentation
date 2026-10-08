#!/usr/bin/env bash
# Introspection SETUP: two string fields on Article — field_ecf_attr uses the
# entity_class_formatter formatter writing into a custom HTML attribute (data-ecf-variant),
# field_ecf_plain uses the plain "string" formatter. The agent must inspect the live view
# display to find which attribute name is configured. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_ecf_attr" => "ECF Variant", "field_ecf_plain" => "ECF Plain"] as $fn => $label) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node", "type" => "string",
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create([
        "field_name" => $fn, "entity_type" => "node", "bundle" => "article", "label" => $label,
      ])->save();
    }
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ecf_attr", [
    "type" => "entity_class_formatter", "label" => "hidden", "weight" => 61, "region" => "content",
    "settings" => ["prefix" => "", "suffix" => "", "attr" => "data-ecf-variant", "field" => ""],
    "third_party_settings" => [],
  ]);
  $vd->setComponent("field_ecf_plain", [
    "type" => "string", "label" => "above", "weight" => 62, "region" => "content",
    "settings" => ["link_to_entity" => FALSE], "third_party_settings" => [],
  ]);
  $vd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ecf_attr -> entity_class_formatter attr=data-ecf-variant; field_ecf_plain -> string"
