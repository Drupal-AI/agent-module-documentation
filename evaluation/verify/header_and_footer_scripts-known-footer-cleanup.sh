#!/usr/bin/env bash
# Introspection CLEANUP: delete the footer settings config (baseline = absent). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("header_and_footer_scripts.footer.settings")->delete();' >/dev/null 2>&1
echo "cleanup: header_and_footer_scripts.footer.settings removed"
