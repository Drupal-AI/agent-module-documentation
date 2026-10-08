#!/usr/bin/env bash
# Introspection SETUP: create a viewsreference field field_vrf_known on Article with the
# viewsreference_filter "exposed_filters" setting plugin ENABLED via enabled_settings, so an
# inspecting agent can read back which field has editor exposed filters turned on. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_vrf_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_vrf_known", "entity_type" => "node",
      "type" => "viewsreference", "settings" => ["target_type" => "view"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_vrf_known")) {
    FieldConfig::create([
      "field_name" => "field_vrf_known", "entity_type" => "node", "bundle" => "article",
      "label" => "Known View Ref",
      "settings" => ["enabled_settings" => ["exposed_filters" => "exposed_filters"]],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_vrf_known (viewsreference) has enabled_settings.exposed_filters"
