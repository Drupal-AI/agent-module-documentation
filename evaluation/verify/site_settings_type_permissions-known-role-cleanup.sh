#!/usr/bin/env bash
# Introspection CLEANUP: delete the probe role and the two probe site settings types.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntityType;
  use Drupal\user\Entity\Role;
  // Reset the storage static cache first: a role modified by another process can
  // otherwise be returned stale and the delete silently does nothing.
  \Drupal::entityTypeManager()->getStorage("user_role")->resetCache();
  if ($r = Role::load("sstp_probe_editor")) { $r->delete(); }
  foreach (["sstp_probe_alpha", "sstp_probe_beta"] as $id) {
    foreach (\Drupal::entityTypeManager()->getStorage("site_setting_entity")->loadByProperties(["type" => $id]) as $e) { $e->delete(); }
    if ($t = SiteSettingEntityType::load($id)) { $t->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sstp_probe_editor role and sstp_probe_* types removed"
