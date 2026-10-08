#!/usr/bin/env bash
# Introspection SETUP: set shariff.settings to a known set of services (whatsapp, telegram,
# reddit) and the grey theme, so an agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("shariff.settings")
    ->set("shariff_services", ["whatsapp"=>"whatsapp","telegram"=>"telegram","reddit"=>"reddit"])
    ->set("shariff_theme", "grey")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: shariff.settings services=whatsapp,telegram,reddit theme=grey"
