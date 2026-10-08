#!/usr/bin/env bash
# MEDIUM introspection setup: create a known authorization_profile config entity so the
# agent can be asked to read back its consumer plugin and its role mapping from live config.
# The profile uses the bundled Drupal Roles consumer and maps a matched proposal to 'editor'.
# Restored by authorization-known-profile-cleanup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("authorization_profile");
  if ($e = $storage->load("known_ldap_editors")) { $e->delete(); }
  $storage->create([
    "id" => "known_ldap_editors",
    "label" => "Known LDAP Editors",
    "provider" => "",
    "provider_config" => [],
    "provider_mappings" => [],
    "consumer" => "authorization_drupal_roles",
    "consumer_config" => [],
    "consumer_mappings" => [["role" => "editor"]],
    "synchronization_modes" => ["user_logon" => "user_logon"],
    "synchronization_actions" => [
      "create_consumers" => "create_consumers",
      "revoke_provider_provisioned" => "revoke_provider_provisioned",
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: authorization_profile 'known_ldap_editors' created (consumer=authorization_drupal_roles, role=editor)"
