#!/usr/bin/env bash
# Introspection CLEANUP: delete the sstp_list_type site settings type. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntityType;
  foreach (\Drupal::entityTypeManager()->getStorage("site_setting_entity")->loadByProperties(["type" => "sstp_list_type"]) as $e) { $e->delete(); }
  if ($t = SiteSettingEntityType::load("sstp_list_type")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sstp_list_type removed"
