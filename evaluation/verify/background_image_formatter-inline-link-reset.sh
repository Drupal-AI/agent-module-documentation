#!/usr/bin/env bash
# Execution RESET: ensure content type bif_task2 with image field field_bif_link exists, and set
# its default view display to the plain core 'image' formatter, so verify FAILS until the agent
# switches it to the Background Image formatter (inline + linked). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("bif_task2")) { NodeType::create(["type"=>"bif_task2","name"=>"BIF Task 2"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_bif_link")) {
    FieldStorageConfig::create(["field_name"=>"field_bif_link","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node","bif_task2","field_bif_link")) {
    FieldConfig::create(["field_name"=>"field_bif_link","entity_type"=>"node","bundle"=>"bif_task2","label"=>"Linked Bg"])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","bif_task2","default");
  $vd->setComponent("field_bif_link", ["type"=>"image","label"=>"hidden","weight"=>0,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.bif_task2 field_bif_link present with core image formatter"
