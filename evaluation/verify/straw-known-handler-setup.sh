#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_straw_known2")) {
    FieldStorageConfig::create(["field_name"=>"field_straw_known2","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"taxonomy_term"]])->save();
  }
  if (!($fc = FieldConfig::loadByName("node","article","field_straw_known2"))) {
    $fc = FieldConfig::create(["field_name"=>"field_straw_known2","entity_type"=>"node","bundle"=>"article","label"=>"Known Topics 2"]);
  }
  $fc->setSetting("handler","straw")->setSetting("handler_settings",["target_bundles"=>["tags"=>"tags"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_straw_known2 handler=straw"
