#!/usr/bin/env bash
# Execution RESET: ensure datetime field field_bsd_task exists on Article using the core
# datetime_default widget on the default form display, so verify FAILS until the agent switches
# it to bootstrap_date_widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_bsd_task")) {
    FieldStorageConfig::create(["field_name"=>"field_bsd_task","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_bsd_task")) {
    FieldConfig::create(["field_name"=>"field_bsd_task","entity_type"=>"node","bundle"=>"article","label"=>"BSD Task"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bsd_task", ["type"=>"datetime_default","weight"=>50,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_bsd_task present with datetime_default widget"
