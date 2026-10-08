#!/usr/bin/env bash
# Execution RESET: ensure datetime field field_da_task exists on Article with a plain
# datetime_default formatter (NO date_augmenter third-party settings) on the default view display,
# so verify FAILS until the agent configures date augmenters. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_da_task")) {
    FieldStorageConfig::create(["field_name"=>"field_da_task","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_da_task")) {
    FieldConfig::create(["field_name"=>"field_da_task","entity_type"=>"node","bundle"=>"article","label"=>"DA Task Date"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_da_task", ["type"=>"datetime_default","label"=>"above","weight"=>53,"region"=>"content","third_party_settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_da_task present, no date_augmenter settings"
