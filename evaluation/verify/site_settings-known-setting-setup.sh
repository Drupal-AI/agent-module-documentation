#!/usr/bin/env bash
# Introspection SETUP: create a site settings GROUP (ss_eval_group), a settings TYPE
# (ss_eval_phone, multiple = FALSE) with a string field field_ss_eval_number, and one
# site_setting_entity holding a known value, so the agent must inspect the running site to read
# the stored setting back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntityType;
  use Drupal\site_settings\Entity\SiteSettingGroupEntityType;
  use Drupal\site_settings\Entity\SiteSettingEntity;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!SiteSettingGroupEntityType::load("ss_eval_group")) {
    SiteSettingGroupEntityType::create(["id" => "ss_eval_group", "label" => "SS Eval Group"])->save();
  }
  if (!SiteSettingEntityType::load("ss_eval_phone")) {
    SiteSettingEntityType::create([
      "id" => "ss_eval_phone", "label" => "SS Eval Phone",
      "group" => "ss_eval_group", "multiple" => FALSE,
    ])->save();
  }
  if (!FieldStorageConfig::loadByName("site_setting_entity", "field_ss_eval_number")) {
    FieldStorageConfig::create([
      "field_name" => "field_ss_eval_number", "entity_type" => "site_setting_entity", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("site_setting_entity", "ss_eval_phone", "field_ss_eval_number")) {
    FieldConfig::create([
      "field_name" => "field_ss_eval_number", "entity_type" => "site_setting_entity",
      "bundle" => "ss_eval_phone", "label" => "Number",
    ])->save();
  }
  $existing = \Drupal::entityTypeManager()->getStorage("site_setting_entity")->loadByProperties(["type" => "ss_eval_phone"]);
  foreach ($existing as $e) { $e->delete(); }
  SiteSettingEntity::create([
    "type" => "ss_eval_phone", "name" => "SS Eval Phone", "group" => "ss_eval_group",
    "status" => 1, "field_ss_eval_number" => "+44 20 7946 0999",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: site setting ss_eval_phone in group ss_eval_group holds field_ss_eval_number '+44 20 7946 0999'"
