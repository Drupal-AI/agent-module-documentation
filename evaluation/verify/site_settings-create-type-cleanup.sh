#!/usr/bin/env bash
# Execution CLEANUP: delete the site settings type ss_task_strapline (its entities, its field and
# its config entity) plus the group ss_task_group, returning the site to baseline after the
# execution case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntityType;
  use Drupal\site_settings\Entity\SiteSettingGroupEntityType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (\Drupal::entityTypeManager()->getStorage("site_setting_entity")->loadByProperties(["type" => "ss_task_strapline"]) as $e) { $e->delete(); }
  if ($fc = FieldConfig::loadByName("site_setting_entity", "ss_task_strapline", "field_ss_task_text")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("site_setting_entity", "field_ss_task_text")) { $fs->delete(); }
  if ($t = SiteSettingEntityType::load("ss_task_strapline")) { $t->delete(); }
  if ($g = SiteSettingGroupEntityType::load("ss_task_group")) { $g->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ss_task_strapline type/field and ss_task_group removed"
