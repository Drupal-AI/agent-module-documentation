#!/usr/bin/env bash
# Execution RESET: create the site settings type sstp_view_type with one published site setting
# entity, and make sure the ANONYMOUS role holds neither the global nor the per-type view
# permission, so an anonymous view access check FAILS until the agent grants the per-type one.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntityType;
  use Drupal\site_settings\Entity\SiteSettingEntity;
  if (!SiteSettingEntityType::load("sstp_view_type")) {
    SiteSettingEntityType::create(["id" => "sstp_view_type", "label" => "SSTP View Type", "group" => "", "multiple" => FALSE])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntity;
  use Drupal\user\Entity\Role;
  foreach (\Drupal::entityTypeManager()->getStorage("site_setting_entity")->loadByProperties(["type" => "sstp_view_type"]) as $e) { $e->delete(); }
  SiteSettingEntity::create(["type" => "sstp_view_type", "name" => "SSTP View Type", "group" => "", "status" => 1])->save();
  $anon = Role::load("anonymous");
  $anon->revokePermission("view published site setting entities");
  $anon->revokePermission("view published sstp_view_type site setting entities");
  $anon->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: sstp_view_type setting exists; anonymous role has no view permission for it"
