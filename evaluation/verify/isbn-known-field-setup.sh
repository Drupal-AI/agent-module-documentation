#!/usr/bin/env bash
# Introspection SETUP: add an ISBN field (type "isbn") field_isbn_known to Article so an
# inspecting agent can read back its machine name. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_isbn_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_isbn_known", "entity_type" => "node", "type" => "isbn",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_isbn_known")) {
    FieldConfig::create([
      "field_name" => "field_isbn_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Book ISBN",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article has ISBN field field_isbn_known (type=isbn)"
