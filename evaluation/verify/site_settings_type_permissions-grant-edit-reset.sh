#!/usr/bin/env bash
# Execution RESET: create the site settings type sstp_task_type (so its per-type permissions
# exist) and a role sstp_task_role holding NO site settings permissions at all, so verify FAILS
# until the agent grants the type-specific edit permission. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntityType;
  if (!SiteSettingEntityType::load("sstp_task_type")) {
    SiteSettingEntityType::create(["id" => "sstp_task_type", "label" => "SSTP Task Type", "group" => "", "multiple" => FALSE])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("sstp_task_role")) {
    Role::create(["id" => "sstp_task_role", "label" => "SSTP Task Role"])->save();
  }
  $r = Role::load("sstp_task_role");
  foreach ($r->getPermissions() as $p) { $r->revokePermission($p); }
  $r->grantPermission("access content");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: sstp_task_type exists; role sstp_task_role has no site settings permissions"
