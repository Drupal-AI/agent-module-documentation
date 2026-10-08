#!/usr/bin/env bash
# Introspection SETUP: two viewsreference fields on Article — field_vrf_on has exposed_filters
# ENABLED, field_vrf_off does not. Agent must inspect enabled_settings to tell them apart.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_vrf_on", "field_vrf_off"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node",
        "type" => "viewsreference", "settings" => ["target_type" => "view"],
      ])->save();
    }
  }
  if (!FieldConfig::loadByName("node", "article", "field_vrf_on")) {
    FieldConfig::create([
      "field_name" => "field_vrf_on", "entity_type" => "node", "bundle" => "article",
      "label" => "Ref On",
      "settings" => ["enabled_settings" => ["exposed_filters" => "exposed_filters"]],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_vrf_off")) {
    FieldConfig::create([
      "field_name" => "field_vrf_off", "entity_type" => "node", "bundle" => "article",
      "label" => "Ref Off", "settings" => ["enabled_settings" => []],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_vrf_on exposed_filters ENABLED, field_vrf_off not"
