#!/usr/bin/env bash
# Execution CLEANUP: revoke the per-type permission from anonymous, delete the sstp_view_type
# setting and its type, and restore the anonymous role's global 'view published site setting
# entities' permission (which site_settings_install() grants by default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntityType;
  use Drupal\user\Entity\Role;
  $anon = Role::load("anonymous");
  if ($anon) {
    $anon->revokePermission("view published sstp_view_type site setting entities");
    $anon->grantPermission("view published site setting entities");
    $anon->save();
  }
  foreach (\Drupal::entityTypeManager()->getStorage("site_setting_entity")->loadByProperties(["type" => "sstp_view_type"]) as $e) { $e->delete(); }
  if ($t = SiteSettingEntityType::load("sstp_view_type")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sstp_view_type removed, anonymous global view permission restored"
