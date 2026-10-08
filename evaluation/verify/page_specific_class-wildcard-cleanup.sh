#!/usr/bin/env bash
# Introspection CLEANUP: restore empty page_specific_class mapping (baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("page_specific_class.settings")->set("url_with_class", "")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: page_specific_class.settings url_with_class='' (baseline)"
