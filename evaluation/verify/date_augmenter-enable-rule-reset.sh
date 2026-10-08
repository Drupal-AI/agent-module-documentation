#!/usr/bin/env bash
# Execution RESET: datetime field field_da_recurring on Article with a plain datetime_default
# formatter, no date_augmenter settings, so verify FAILS until the agent enables an augmenter on
# the recurring 'rule' set. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_da_recurring")) {
    FieldStorageConfig::create(["field_name"=>"field_da_recurring","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_da_recurring")) {
    FieldConfig::create(["field_name"=>"field_da_recurring","entity_type"=>"node","bundle"=>"article","label"=>"DA Recurring Date"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_da_recurring", ["type"=>"datetime_default","label"=>"above","weight"=>54,"region"=>"content","third_party_settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_da_recurring present, no date_augmenter settings"
