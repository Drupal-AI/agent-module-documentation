#!/usr/bin/env bash
# Execution RESET: h5p field field_h5pe_task on Article with the UPLOAD widget (h5p_upload) so
# verify FAILS until the agent switches it to h5p_editor. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_h5pe_task")) {
    FieldStorageConfig::create(["field_name"=>"field_h5pe_task","entity_type"=>"node","type"=>"h5p"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_h5pe_task")) {
    FieldConfig::create(["field_name"=>"field_h5pe_task","entity_type"=>"node","bundle"=>"article","label"=>"H5PE Task"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_h5pe_task",["type"=>"h5p_upload","weight"=>62,"region"=>"content"])->save();
' >/dev/null 2>&1
echo "reset: field_h5pe_task uses widget h5p_upload"
