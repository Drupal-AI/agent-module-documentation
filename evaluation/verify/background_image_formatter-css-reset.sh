#!/usr/bin/env bash
# Execution RESET: ensure content type bif_task with image field field_bif_task exists, and set
# its default view display to the plain core 'image' formatter (NOT background), so verify FAILS
# until the agent switches it to the Background Image formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("bif_task")) { NodeType::create(["type"=>"bif_task","name"=>"BIF Task"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_bif_task")) {
    FieldStorageConfig::create(["field_name"=>"field_bif_task","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node","bif_task","field_bif_task")) {
    FieldConfig::create(["field_name"=>"field_bif_task","entity_type"=>"node","bundle"=>"bif_task","label"=>"Task Image"])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","bif_task","default");
  $vd->setComponent("field_bif_task", ["type"=>"image","label"=>"hidden","weight"=>0,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.bif_task field_bif_task present with core image formatter"
