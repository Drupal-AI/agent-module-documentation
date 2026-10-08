#!/usr/bin/env bash
# Execution RESET: ensure datetime field field_bsd_auto exists on Article using the core
# datetime_default widget, so verify FAILS until the agent switches to bootstrap_date_widget and
# enables autoclose. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_bsd_auto")) {
    FieldStorageConfig::create(["field_name"=>"field_bsd_auto","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_bsd_auto")) {
    FieldConfig::create(["field_name"=>"field_bsd_auto","entity_type"=>"node","bundle"=>"article","label"=>"BSD Auto"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bsd_auto", ["type"=>"datetime_default","weight"=>50,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_bsd_auto present with datetime_default widget"
