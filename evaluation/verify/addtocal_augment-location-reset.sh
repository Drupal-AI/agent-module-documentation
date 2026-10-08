#!/usr/bin/env bash
# Execution RESET: ensure datetime field field_atc_loc on Article (datetime_default formatter in
# node.article.default) with addtocal OFF and NO location set, so verify FAILS until the agent
# enables addtocal AND sets its event location + label. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_atc_loc")) {
    FieldStorageConfig::create(["field_name" => "field_atc_loc", "entity_type" => "node", "type" => "datetime", "settings" => ["datetime_type" => "datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_atc_loc")) {
    FieldConfig::create(["field_name" => "field_atc_loc", "entity_type" => "node", "bundle" => "article", "label" => "Location Event"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_atc_loc", [
    "type" => "datetime_default", "weight" => 62, "region" => "content",
    "third_party_settings" => ["date_augmenter" => ["instances" => [
      "status" => ["addtocal" => FALSE],
    ]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_atc_loc present, addtocal OFF, no location"
