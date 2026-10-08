#!/usr/bin/env bash
# Introspection SETUP: create namespaced content type mask_ct with a string_textfield field
# field_mask_known whose widget has a known Mask value '(00) 0000-0000' on the default form
# display, so an inspecting agent can read the mask back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("mask_ct")) { NodeType::create(["type"=>"mask_ct","name"=>"Mask CT"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_mask_known")) {
    FieldStorageConfig::create(["field_name"=>"field_mask_known","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","mask_ct","field_mask_known")) {
    FieldConfig::create(["field_name"=>"field_mask_known","entity_type"=>"node","bundle"=>"mask_ct","label"=>"Known Phone"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","mask_ct","default");
  $fd->setComponent("field_mask_known", [
    "type"=>"string_textfield","weight"=>60,"region"=>"content",
    "third_party_settings"=>["mask"=>["value"=>"(00) 0000-0000","reverse"=>FALSE,"clearifnotmatch"=>FALSE,"selectonfocus"=>FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.mask_ct field_mask_known string_textfield mask value='(00) 0000-0000'"
