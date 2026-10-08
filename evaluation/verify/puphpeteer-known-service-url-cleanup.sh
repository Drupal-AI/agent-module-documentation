#!/usr/bin/env bash
# Introspection CLEANUP: delete the puphpeteer.settings config object to restore the
# disabled baseline (module ships nothing while disabled). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("puphpeteer.settings")->delete();' >/dev/null 2>&1
echo "cleanup: puphpeteer.settings deleted"
