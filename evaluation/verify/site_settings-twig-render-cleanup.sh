#!/usr/bin/env bash
# Execution CLEANUP: remove the snippet directory, the stored setting, its field and its type.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/sites/default/files/site_settings_eval
drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntityType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (\Drupal::entityTypeManager()->getStorage("site_setting_entity")->loadByProperties(["type" => "ss_render_label"]) as $e) { $e->delete(); }
  if ($fc = FieldConfig::loadByName("site_setting_entity", "ss_render_label", "field_ss_render_text")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("site_setting_entity", "field_ss_render_text")) { $fs->delete(); }
  if ($t = SiteSettingEntityType::load("ss_render_label")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ss_render_label type/field/entity and snippet dir removed"
