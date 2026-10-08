#!/usr/bin/env bash
# Execution RESET: ensure namespaced content type mask_ct has a string_textfield field
# field_mask_task with an EMPTY Mask value on the default form display (verify FAILS until the
# agent sets the mask). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("mask_ct")) { NodeType::create(["type"=>"mask_ct","name"=>"Mask CT"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_mask_task")) {
    FieldStorageConfig::create(["field_name"=>"field_mask_task","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","mask_ct","field_mask_task")) {
    FieldConfig::create(["field_name"=>"field_mask_task","entity_type"=>"node","bundle"=>"mask_ct","label"=>"Task Date"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","mask_ct","default");
  $fd->setComponent("field_mask_task", [
    "type"=>"string_textfield","weight"=>60,"region"=>"content",
    "third_party_settings"=>["mask"=>["value"=>"","reverse"=>FALSE,"clearifnotmatch"=>FALSE,"selectonfocus"=>FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.mask_ct field_mask_task present, mask value empty"
