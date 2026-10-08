#!/usr/bin/env bash
# Execution RESET: ensure a Date range field field_tr_task exists on Article using the core
# daterange_default widget (NOT time_range), so verify FAILS until the agent switches the
# widget to Time Range. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_tr_task")) {
    \Drupal\field\Entity\FieldStorageConfig::create(["field_name"=>"field_tr_task","entity_type"=>"node","type"=>"daterange","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node","article","field_tr_task")) {
    \Drupal\field\Entity\FieldConfig::create(["field_name"=>"field_tr_task","entity_type"=>"node","bundle"=>"article","label"=>"Session window"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_tr_task",["type"=>"daterange_default","weight"=>50,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_tr_task uses daterange_default (not time_range)"
