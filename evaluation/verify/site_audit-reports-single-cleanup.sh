#!/usr/bin/env bash
# Introspection CLEANUP: delete site_audit.settings (baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("site_audit.settings")->delete();' >/dev/null 2>&1
echo "cleanup: site_audit.settings removed"
