#!/usr/bin/env bash
# Execution RESET: delete gtext.settings so no Google API key is configured (verify FAILS until
# the agent sets the requested key). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gtext.settings")->delete();' >/dev/null 2>&1
echo "reset: gtext.settings deleted (no API key)"
