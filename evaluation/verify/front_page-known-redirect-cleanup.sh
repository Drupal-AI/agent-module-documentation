#!/usr/bin/env bash
# Introspection CLEANUP: reset front_page.settings to baseline (override off, no roles). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("front_page.settings")
    ->set("enabled", FALSE)->set("roles", [])->clear("home_link_path")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: front_page.settings reset to baseline"
