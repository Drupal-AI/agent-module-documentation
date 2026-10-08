#!/usr/bin/env bash
# Introspection SETUP: set pwa.config theme_color to a known value '#123456'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa.config")->set("theme_color","#123456")->save();' >/dev/null 2>&1
echo "setup: pwa.config theme_color=#123456"
