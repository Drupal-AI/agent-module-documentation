#!/usr/bin/env bash
# Introspection SETUP: add an entity_access_by_role_field to Article that governs ONLY the
# 'view' operation (update/delete off), so an agent can read the instance 'operations' setting.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_eabrf_ops")) {
    FieldStorageConfig::create(["field_name"=>"field_eabrf_ops","entity_type"=>"node","type"=>"entity_access_by_role_field"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_eabrf_ops")) {
    FieldConfig::create(["field_name"=>"field_eabrf_ops","entity_type"=>"node","bundle"=>"article","label"=>"Role access (ops)","settings"=>["operations"=>["view"=>"view","update"=>0,"delete"=>0],"empty_roles_access_fallback"=>"neutral"]])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_eabrf_ops operations=[view] only"
