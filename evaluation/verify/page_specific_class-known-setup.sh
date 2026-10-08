#!/usr/bin/env bash
# Introspection SETUP: configure page_specific_class so /node/1 gets a known body class. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("page_specific_class.settings")->set("url_with_class", "/node/1|psc-known-class")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: page_specific_class.settings url_with_class='/node/1|psc-known-class'"
