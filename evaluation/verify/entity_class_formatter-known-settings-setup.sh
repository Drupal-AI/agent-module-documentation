#!/usr/bin/env bash
# Introspection SETUP: create a string field field_ecf_known on Article and configure
# its component in the DEFAULT view display to use the entity_class_formatter formatter with
# a known prefix/suffix, so an inspecting agent can read the settings back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ecf_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_ecf_known", "entity_type" => "node", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ecf_known")) {
    FieldConfig::create([
      "field_name" => "field_ecf_known", "entity_type" => "node",
      "bundle" => "article", "label" => "ECF Theme Colour",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ecf_known", [
    "type" => "entity_class_formatter", "label" => "hidden", "weight" => 60, "region" => "content",
    "settings" => ["prefix" => "ecfx-", "suffix" => "-tone", "attr" => "", "field" => ""],
    "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ecf_known uses entity_class_formatter prefix=ecfx- suffix=-tone"
