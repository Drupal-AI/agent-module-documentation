#!/usr/bin/env bash
# Introspection SETUP: create image fields field_sir_on (enable_rotate TRUE) and field_sir_off (FALSE). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  foreach (["field_sir_on"=>TRUE,"field_sir_off"=>FALSE] as $name=>$val) {
    if (!FieldStorageConfig::loadByName("node",$name)) {
      FieldStorageConfig::create(["field_name"=>$name,"entity_type"=>"node","type"=>"image"])->save();
    }
    $fc = FieldConfig::loadByName("node","article",$name);
    if (!$fc) { $fc = FieldConfig::create(["field_name"=>$name,"entity_type"=>"node","bundle"=>"article","label"=>$name]); }
    $fc->setThirdPartySetting("simple_image_rotate","enable_rotate",$val); $fc->save();
  }
' >/dev/null 2>&1
echo "setup: field_sir_on=TRUE, field_sir_off=FALSE"
