#!/usr/bin/env bash
# Execution RESET: ensure a datetime field field_atc_task exists on Article with a datetime_default
# formatter in node.article.default, and force the addtocal Date Augmenter OFF (status.addtocal
# false), so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_atc_task")) {
    FieldStorageConfig::create(["field_name" => "field_atc_task", "entity_type" => "node", "type" => "datetime", "settings" => ["datetime_type" => "datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_atc_task")) {
    FieldConfig::create(["field_name" => "field_atc_task", "entity_type" => "node", "bundle" => "article", "label" => "Task Event"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_atc_task", [
    "type" => "datetime_default", "weight" => 61, "region" => "content",
    "third_party_settings" => ["date_augmenter" => ["instances" => [
      "status" => ["addtocal" => FALSE],
    ]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_atc_task present, addtocal augmenter OFF"
