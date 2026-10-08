#!/usr/bin/env bash
# MEDIUM introspection cleanup for config_perms: remove exactly the custom_perms_entity
# seeded by config_perms-known-permission-setup.sh, restoring the baseline. Ships-with
# default permissions and any user-created ones are left untouched.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("custom_perms_entity");
  if ($e = $storage->load("known_site_info_perm")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed custom_perms_entity 'known_site_info_perm'"
