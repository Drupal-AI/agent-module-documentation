#!/usr/bin/env bash
# Introspection SETUP: write a KNOWN gtm.settings baseline so an inspecting agent can read
# back the live container ID and enable state. Container ID GTM-EVAL01, GTM enabled,
# front-end only (admin-pages off), superuser excluded (admin-disable on). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gtm.settings")
    ->set("enable", 1)
    ->set("google-tag", "GTM-EVAL01")
    ->set("admin-pages", 0)
    ->set("admin-disable", 1)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: gtm.settings google-tag=GTM-EVAL01 enable=1 admin-pages=0 admin-disable=1"
