#!/usr/bin/env bash
# Execution CLEANUP: delete the sstp_task_role role and the sstp_task_type settings type.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntityType;
  use Drupal\user\Entity\Role;
  // Reset the storage static cache first: a role modified by another process can
  // otherwise be returned stale and the delete silently does nothing.
  \Drupal::entityTypeManager()->getStorage("user_role")->resetCache();
  if ($r = Role::load("sstp_task_role")) { $r->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("site_setting_entity")->loadByProperties(["type" => "sstp_task_type"]) as $e) { $e->delete(); }
  if ($t = SiteSettingEntityType::load("sstp_task_type")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sstp_task_role and sstp_task_type removed"
