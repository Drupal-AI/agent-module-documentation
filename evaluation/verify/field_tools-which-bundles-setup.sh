#!/usr/bin/env bash
# Introspection SETUP: add field_ft_seen (a plain text field) to the article AND page
# content types so an inspecting agent can read back which bundles have it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ft_seen")) {
    FieldStorageConfig::create([
      "field_name" => "field_ft_seen", "entity_type" => "node", "type" => "string",
    ])->save();
  }
  foreach (["article", "page"] as $bundle) {
    if (!FieldConfig::loadByName("node", $bundle, "field_ft_seen")) {
      FieldConfig::create([
        "field_name" => "field_ft_seen", "entity_type" => "node",
        "bundle" => $bundle, "label" => "FT Seen",
      ])->save();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ft_seen present on node.article and node.page"
