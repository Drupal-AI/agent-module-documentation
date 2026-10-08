#!/usr/bin/env bash
# Execution RESET: ensure content type name_cth EXISTS but has NO name field field_name_cth
# (delete the field/storage if present), so verify FAILS until the agent adds the field.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("name_cth")) {
    NodeType::create(["type" => "name_cth", "name" => "Name CT Hard"])->save();
  }
  if ($fc = FieldConfig::loadByName("node", "name_cth", "field_name_cth")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_name_cth")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node type name_cth present, field_name_cth absent"
