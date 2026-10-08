#!/usr/bin/env bash
# Introspection CLEANUP: delete puphpeteer.settings to restore the disabled baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("puphpeteer.settings")->delete();' >/dev/null 2>&1
echo "cleanup: puphpeteer.settings deleted"
