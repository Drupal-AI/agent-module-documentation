#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped chart defaults (colormap summer, alpha 40, shades 15).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("dashboards.settings")->set("colormap","summer")->set("alpha",40)->set("shades",15)->save();' >/dev/null 2>&1
echo "cleanup: dashboards.settings restored (colormap=summer)"
