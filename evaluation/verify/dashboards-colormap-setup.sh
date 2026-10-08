#!/usr/bin/env bash
# Introspection SETUP: set a known chart colormap in dashboards.settings. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("dashboards.settings")->set("colormap","viridis")->save();' >/dev/null 2>&1
echo "setup: dashboards.settings colormap=viridis"
