#!/usr/bin/env bash
# Introspection SETUP: create a cardinality-3 string field on Article and enable
# field_widget_add_more "Show add more button" on its widget, so an inspecting agent can read
# back which field has the third-party setting. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fwam_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_fwam_known", "entity_type" => "node",
      "type" => "string", "cardinality" => 3,
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fwam_known")) {
    FieldConfig::create([
      "field_name" => "field_fwam_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Capped Field",
    ])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_fwam_known", [
    "type" => "string_textfield", "weight" => 60, "region" => "content",
    "third_party_settings" => ["field_widget_add_more" => ["add_more" => TRUE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_fwam_known (cardinality 3) has field_widget_add_more.add_more=true"
