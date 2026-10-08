#!/usr/bin/env bash
# Introspection SETUP: create an Image field field_ift_wid on Article and set its form-display widget
# to imagefield_tokens, so an agent can discover which field uses the token widget. Idempotent. Exit 0.
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
  _ift_field("field_ift_wid");
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_ift_wid", ["type"=>"imagefield_tokens","weight"=>50,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ift_wid uses the imagefield_tokens widget"
