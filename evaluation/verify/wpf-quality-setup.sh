#!/usr/bin/env bash
# Introspection SETUP: set the Webp fallback JPEG quality to 40 so an inspecting agent can read it
# back from wpf.settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("wpf.settings")->set("quality", 40)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: wpf.settings quality=40"
