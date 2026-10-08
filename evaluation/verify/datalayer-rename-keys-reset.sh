#!/usr/bin/env bash
# HARD reset: restore entity_type and site_name JSON keys to their defaults so
# verify FAILS; the agent must rename them to contentType / siteTitle.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("datalayer.settings")
    ->set("entity_type", "entityType")->set("site_name", "siteName")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: datalayer entity_type=entityType site_name=siteName"
