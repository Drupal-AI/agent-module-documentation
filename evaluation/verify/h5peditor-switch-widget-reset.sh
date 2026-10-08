#!/usr/bin/env bash
# Execution RESET: h5p field field_h5pe_switch on Article using h5p_upload so verify FAILS until
# switched to h5p_editor. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_h5pe_switch")) {
    FieldStorageConfig::create(["field_name"=>"field_h5pe_switch","entity_type"=>"node","type"=>"h5p"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_h5pe_switch")) {
    FieldConfig::create(["field_name"=>"field_h5pe_switch","entity_type"=>"node","bundle"=>"article","label"=>"H5PE Switch"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_h5pe_switch",["type"=>"h5p_upload","weight"=>63,"region"=>"content"])->save();
' >/dev/null 2>&1
echo "reset: field_h5pe_switch uses widget h5p_upload"
