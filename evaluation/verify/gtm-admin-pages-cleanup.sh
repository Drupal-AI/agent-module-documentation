#!/usr/bin/env bash
# Introspection CLEANUP: restore gtm.settings to install defaults (all off, empty ID),
# undoing the admin-pages known config set by the matching setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gtm.settings")
    ->set("enable", 0)
    ->set("google-tag", "")
    ->set("admin-pages", 0)
    ->set("admin-disable", 0)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: gtm.settings restored to defaults"
