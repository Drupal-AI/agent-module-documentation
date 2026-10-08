#!/usr/bin/env bash
# Introspection SETUP: create an entity_reference(->contact_form) field on Article and set
# its display formatter to contact_field_formatter, so an inspecting agent can read back
# which field renders a contact form inline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_cfmt_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_cfmt_known", "entity_type" => "node",
      "type" => "entity_reference", "settings" => ["target_type" => "contact_form"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_cfmt_known")) {
    FieldConfig::create([
      "field_name" => "field_cfmt_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Contact Form",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_cfmt_known", ["type" => "contact_field_formatter", "region" => "content", "weight" => 50])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_cfmt_known uses contact_field_formatter"
