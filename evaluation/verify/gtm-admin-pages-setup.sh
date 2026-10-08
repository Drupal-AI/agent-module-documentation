#!/usr/bin/env bash
# Introspection SETUP: configure gtm.settings with a KNOWN insertion condition so an agent
# can read back WHERE the container fires. Container GTM-ADMIN9, enabled, and explicitly set
# to ALSO load on admin pages (admin-pages=1). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gtm.settings")
    ->set("enable", 1)
    ->set("google-tag", "GTM-ADMIN9")
    ->set("admin-pages", 1)
    ->set("admin-disable", 0)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: gtm.settings google-tag=GTM-ADMIN9 enable=1 admin-pages=1 admin-disable=0"
