#!/usr/bin/env bash
# Execution RESET: create the site settings type ss_render_label with a field and ONE stored
# value, and delete the snippet directory web/sites/default/files/site_settings_eval so verify
# FAILS until the agent writes a Twig template that renders the setting. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/sites/default/files/site_settings_eval
drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntityType;
  use Drupal\site_settings\Entity\SiteSettingEntity;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!SiteSettingEntityType::load("ss_render_label")) {
    SiteSettingEntityType::create([
      "id" => "ss_render_label", "label" => "SS Render Label", "group" => "", "multiple" => FALSE,
    ])->save();
  }
  if (!FieldStorageConfig::loadByName("site_setting_entity", "field_ss_render_text")) {
    FieldStorageConfig::create([
      "field_name" => "field_ss_render_text", "entity_type" => "site_setting_entity", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("site_setting_entity", "ss_render_label", "field_ss_render_text")) {
    FieldConfig::create([
      "field_name" => "field_ss_render_text", "entity_type" => "site_setting_entity",
      "bundle" => "ss_render_label", "label" => "Text",
    ])->save();
  }
  // Make sure the field is actually rendered by the default view display, otherwise
  // viewField() would return nothing for the Twig functions.
  \Drupal::service("entity_display.repository")
    ->getViewDisplay("site_setting_entity", "ss_render_label", "default")
    ->setComponent("field_ss_render_text", [
      "type" => "string", "label" => "hidden", "weight" => 0, "region" => "content",
      "settings" => ["link_to_entity" => FALSE],
    ])
    ->save();
  foreach (\Drupal::entityTypeManager()->getStorage("site_setting_entity")->loadByProperties(["type" => "ss_render_label"]) as $e) { $e->delete(); }
  SiteSettingEntity::create([
    "type" => "ss_render_label", "name" => "SS Render Label", "group" => "", "status" => 1,
    "field_ss_render_text" => "Book your visit",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ss_render_label setting holds 'Book your visit'; snippet dir removed"
