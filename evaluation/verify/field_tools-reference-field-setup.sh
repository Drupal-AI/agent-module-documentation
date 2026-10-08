#!/usr/bin/env bash
# Introspection SETUP: add an entity_reference field field_ft_ref to node.article that targets
# the user entity type, so an agent can read back the reference and its target. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ft_ref")) {
    FieldStorageConfig::create([
      "field_name" => "field_ft_ref", "entity_type" => "node",
      "type" => "entity_reference", "settings" => ["target_type" => "user"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ft_ref")) {
    FieldConfig::create([
      "field_name" => "field_ft_ref", "entity_type" => "node",
      "bundle" => "article", "label" => "FT Author Ref",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ft_ref (entity_reference -> user) present on node.article"
