#!/usr/bin/env bash
# MEDIUM introspection setup for config_perms: create a known custom_perms_entity so the
# agent can be asked to read back, from live config, which route it gates and its label/id.
# The permission "Manage site information" gates the core site-information settings form.
# Restored by config_perms-known-permission-cleanup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("custom_perms_entity");
  if ($e = $storage->load("known_site_info_perm")) { $e->delete(); }
  $storage->create([
    "id" => "known_site_info_perm",
    "label" => "Manage site information",
    "route" => "system.site_information_settings",
    "status" => TRUE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: custom_perms_entity 'known_site_info_perm' created (label='Manage site information', route=system.site_information_settings)"
