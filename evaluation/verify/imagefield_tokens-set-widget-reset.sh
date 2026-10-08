#!/usr/bin/env bash
# Execution RESET: ensure Image field field_ift_task exists on Article with the plain core image_image
# widget, so verify FAILS until the agent switches it to imagefield_tokens. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  function _ift_field($name) {
    if (!FieldStorageConfig::loadByName("node", $name)) {
      FieldStorageConfig::create(["field_name"=>$name,"entity_type"=>"node","type"=>"image","cardinality"=>1])->save();
    }
    if (!FieldConfig::loadByName("node","article",$name)) {
      FieldConfig::create(["field_name"=>$name,"entity_type"=>"node","bundle"=>"article","label"=>ucfirst($name)])->save();
    }
  }
  _ift_field("field_ift_task");
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_ift_task", ["type"=>"image_image","weight"=>50,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ift_task uses core image_image widget"
