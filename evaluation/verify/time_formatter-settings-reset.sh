#!/usr/bin/env bash
# Execution RESET: ensure field_tf_switch integer field uses number_time with hours=Always(0)
# and display=2, so verify FAILS until the agent changes hours to Never(2). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_tf_switch")) {
    FieldStorageConfig::create(["field_name"=>"field_tf_switch","entity_type"=>"node","type"=>"integer"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_tf_switch")) {
    FieldConfig::create(["field_name"=>"field_tf_switch","entity_type"=>"node","bundle"=>"article","label"=>"TF Switch"])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $vd->setComponent("field_tf_switch", ["type"=>"number_time","label"=>"above","settings"=>["storage"=>1,"display"=>2,"hours"=>0]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_tf_switch number_time with hours=Always(0)"
