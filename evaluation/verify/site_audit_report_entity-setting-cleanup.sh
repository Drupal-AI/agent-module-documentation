#!/usr/bin/env bash
# Introspection CLEANUP: clear the example value. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("site_audit_report_entity.settings")->set("example","")->save();' >/dev/null 2>&1
echo "cleanup: site_audit_report_entity.settings example cleared"
