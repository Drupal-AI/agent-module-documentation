#!/usr/bin/env bash
# Execution RESET (hours_minutes_seconds): ensure field_hms_task exists on Article and its default
# view-display component uses the DEFAULT formatter (not ISO), so verify FAILS until the agent
# switches it to the ISO 8601 formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_hms_task")) {
    FieldStorageConfig::create(["field_name"=>"field_hms_task","entity_type"=>"node","type"=>"hour_minutes_seconds"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_hms_task")) {
    FieldConfig::create(["field_name"=>"field_hms_task","entity_type"=>"node","bundle"=>"article","label"=>"Task Duration"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_hms_task", ["type"=>"hour_minutes_seconds_default_formatter","weight"=>50,"region"=>"content","settings"=>["format"=>"h:mm:ss","leading_zero"=>TRUE,"live_timer"=>FALSE],"label"=>"above"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_hms_task shown with default formatter (not ISO)"
