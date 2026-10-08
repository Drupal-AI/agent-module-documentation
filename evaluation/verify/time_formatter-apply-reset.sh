#!/usr/bin/env bash
# Execution RESET: ensure Article has an integer field field_tf_task whose default view display
# uses the plain number_integer formatter (NOT number_time), so verify FAILS until the agent
# switches it to Time. Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_tf_task")) {
    FieldStorageConfig::create(["field_name"=>"field_tf_task","entity_type"=>"node","type"=>"integer"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_tf_task")) {
    FieldConfig::create(["field_name"=>"field_tf_task","entity_type"=>"node","bundle"=>"article","label"=>"TF Task"])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $vd->setComponent("field_tf_task", ["type"=>"number_integer","label"=>"above","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_tf_task uses number_integer formatter"
