#!/usr/bin/env bash
# HARD execution reset: remove the authorization_profile the agent is asked to build so the
# task starts from a missing (failing) state. Targets the ids the verify script accepts.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("authorization_profile");
  foreach (["staff_roles", "ldap_roles", "role_sync"] as $id) {
    if ($e = $storage->load($id)) { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: candidate authorization_profile entities removed (if they existed)"
