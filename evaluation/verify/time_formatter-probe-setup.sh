#!/usr/bin/env bash
# Introspection SETUP: add an integer field field_tf_probe to Article and set its default view
# display to the number_time ("Time") formatter with storage=Seconds(0), display=3 (123:59:59),
# so an agent can read the formatter + settings back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_tf_probe")) {
    FieldStorageConfig::create(["field_name"=>"field_tf_probe","entity_type"=>"node","type"=>"integer"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_tf_probe")) {
    FieldConfig::create(["field_name"=>"field_tf_probe","entity_type"=>"node","bundle"=>"article","label"=>"TF Probe"])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $vd->setComponent("field_tf_probe", ["type"=>"number_time","label"=>"above","settings"=>["storage"=>0,"display"=>3,"hours"=>0]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_tf_probe uses number_time (storage=Seconds/0, display=3)"
