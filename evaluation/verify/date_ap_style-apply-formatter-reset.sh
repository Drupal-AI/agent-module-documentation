#!/usr/bin/env bash
# Execution RESET: ensure a datetime field field_apstyle_probe exists on Article and its default
# view-display component uses a NON-AP formatter (datetime_default), so verify FAILS until the
# agent switches it to the AP Style formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_apstyle_probe")) {
    FieldStorageConfig::create(["field_name"=>"field_apstyle_probe","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_apstyle_probe")) {
    FieldConfig::create(["field_name"=>"field_apstyle_probe","entity_type"=>"node","bundle"=>"article","label"=>"AP Style Probe Date"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if (!$vd) {
    $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->create(["targetEntityType"=>"node","bundle"=>"article","mode"=>"default","status"=>TRUE]);
  }
  $vd->setComponent("field_apstyle_probe", ["type"=>"datetime_default","weight"=>50,"region"=>"content","label"=>"above","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_apstyle_probe uses datetime_default (non-AP) formatter"
