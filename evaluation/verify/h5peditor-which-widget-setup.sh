#!/usr/bin/env bash
# Introspection SETUP: h5p field field_h5pe_probe on Article with the h5p_editor widget. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_h5pe_probe")) {
    FieldStorageConfig::create(["field_name"=>"field_h5pe_probe","entity_type"=>"node","type"=>"h5p"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_h5pe_probe")) {
    FieldConfig::create(["field_name"=>"field_h5pe_probe","entity_type"=>"node","bundle"=>"article","label"=>"H5PE Probe"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_h5pe_probe",["type"=>"h5p_editor","weight"=>60,"region"=>"content"])->save();
' >/dev/null 2>&1
echo "setup: field_h5pe_probe uses widget h5p_editor"
