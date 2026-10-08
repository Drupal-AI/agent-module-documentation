#!/usr/bin/env bash
# Introspection SETUP: create two fields on Article; only field_fdl_a gets a field_display_label
# display label. Agent must find which one and its value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_fdl_a", "field_fdl_b"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name" => $fn, "entity_type" => "node", "type" => "string"])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create(["field_name" => $fn, "entity_type" => "node", "bundle" => "article", "label" => strtoupper($fn)])->save();
    }
  }
  $fa = FieldConfig::loadByName("node", "article", "field_fdl_a");
  $fa->setThirdPartySetting("field_display_label", "display_label", "Special A Label")->save();
  $fb = FieldConfig::loadByName("node", "article", "field_fdl_b");
  $fb->unsetThirdPartySetting("field_display_label", "display_label")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_fdl_a has display label Special A Label; field_fdl_b has none"
