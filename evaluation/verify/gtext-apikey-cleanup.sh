#!/usr/bin/env bash
# Introspection CLEANUP: delete gtext.settings to restore baseline (no config object, as
# shipped - gtext has no config/install). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gtext.settings")->delete();' >/dev/null 2>&1
echo "cleanup: gtext.settings deleted (baseline)"
