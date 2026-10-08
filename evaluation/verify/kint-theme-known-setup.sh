#!/usr/bin/env bash
# Introspection SETUP: set a known Kint rich theme + early_enable so an agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("kint.settings")
    ->set("rich_theme", "solarized-dark.css")
    ->set("early_enable", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: kint.settings rich_theme=solarized-dark.css, early_enable=TRUE"
