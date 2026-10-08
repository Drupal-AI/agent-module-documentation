#!/usr/bin/env bash
# Introspection SETUP: create a view_mode_switch field field_vms on Article with
# origin_view_modes=[teaser], allowed_view_modes=[teaser,full]. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_vms")) {
    FieldStorageConfig::create(["field_name"=>"field_vms","entity_type"=>"node","type"=>"view_mode_switch","settings"=>["origin_view_modes"=>["teaser"]]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_vms")) {
    FieldConfig::create(["field_name"=>"field_vms","entity_type"=>"node","bundle"=>"article","label"=>"Display as","settings"=>["allowed_view_modes"=>["teaser"=>"teaser","full"=>"full"]]])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_vms origin_view_modes=[teaser]"
