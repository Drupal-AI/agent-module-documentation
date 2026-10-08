#!/usr/bin/env bash
# MEDIUM introspection cleanup: delete the known_ldap_editors authorization_profile so the
# site returns to its baseline (no authorization profiles).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("authorization_profile")->load("known_ldap_editors");
  if ($e) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: authorization_profile 'known_ldap_editors' removed"
