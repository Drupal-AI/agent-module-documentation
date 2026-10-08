#!/usr/bin/env bash
# Execution RESET: (re)create field_vms on Article with allowed_view_modes=[teaser] ONLY, so
# verify FAILS until the agent adds 'full'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_vms")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_vms")) { $fs->delete(); }
  FieldStorageConfig::create(["field_name"=>"field_vms","entity_type"=>"node","type"=>"view_mode_switch","settings"=>["origin_view_modes"=>["full"]]])->save();
  FieldConfig::create(["field_name"=>"field_vms","entity_type"=>"node","bundle"=>"article","label"=>"Display as","settings"=>["allowed_view_modes"=>["teaser"=>"teaser"]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_vms allowed_view_modes=[teaser]"
