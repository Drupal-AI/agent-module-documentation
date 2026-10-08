#!/usr/bin/env bash
# Introspection CLEANUP: delete the eval site setting entity, its type, its field and its group.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntityType;
  use Drupal\site_settings\Entity\SiteSettingGroupEntityType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (\Drupal::entityTypeManager()->getStorage("site_setting_entity")->loadByProperties(["type" => "ss_eval_phone"]) as $e) { $e->delete(); }
  if ($fc = FieldConfig::loadByName("site_setting_entity", "ss_eval_phone", "field_ss_eval_number")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("site_setting_entity", "field_ss_eval_number")) { $fs->delete(); }
  if ($t = SiteSettingEntityType::load("ss_eval_phone")) { $t->delete(); }
  if ($g = SiteSettingGroupEntityType::load("ss_eval_group")) { $g->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ss_eval_phone type/entity/field and ss_eval_group removed"
