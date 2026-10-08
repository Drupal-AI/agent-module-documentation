#!/usr/bin/env bash
# Execution RESET (tzfield widget): ensure a Time zone field field_tz_widget exists on Article
# using the DEFAULT widget (tzfield_default), so verify FAILS until the agent switches it to the
# "Time zone with current offset" (tzfield_offset) widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_tz_widget")) {
    FieldStorageConfig::create(["field_name"=>"field_tz_widget","entity_type"=>"node","type"=>"tzfield"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_tz_widget")) {
    FieldConfig::create(["field_name"=>"field_tz_widget","entity_type"=>"node","bundle"=>"article","label"=>"Widget Time Zone"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_tz_widget",["type"=>"tzfield_default","region"=>"content","weight"=>41])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_tz_widget present with widget tzfield_default"
