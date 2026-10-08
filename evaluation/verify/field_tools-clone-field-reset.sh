#!/usr/bin/env bash
# Execution RESET for "clone field_ft_source from Article to Page".
# Ensure field_ft_source exists on node.article, and ensure it does NOT exist on node.page
# (so verify FAILS until the agent clones it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ft_source")) {
    FieldStorageConfig::create([
      "field_name" => "field_ft_source", "entity_type" => "node", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ft_source")) {
    FieldConfig::create([
      "field_name" => "field_ft_source", "entity_type" => "node",
      "bundle" => "article", "label" => "FT Source",
    ])->save();
  }
  if ($fc = FieldConfig::loadByName("node", "page", "field_ft_source")) { $fc->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ft_source on node.article only (not on node.page)"
