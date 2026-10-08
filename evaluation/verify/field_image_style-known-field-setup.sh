#!/usr/bin/env bash
# Introspection SETUP: create an image_style field field_fis_known on Article, restricted to
# the 'medium' and 'wide' image styles (sort by label), so an agent can read back the allowed
# styles from field storage. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fis_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_fis_known", "entity_type" => "node", "type" => "image_style",
      "cardinality" => 1,
      "settings" => ["allowed_values" => ["medium" => "medium", "wide" => "wide"], "sort" => TRUE],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fis_known")) {
    FieldConfig::create([
      "field_name" => "field_fis_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Display Style",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_fis_known (image_style) allows medium,wide"
