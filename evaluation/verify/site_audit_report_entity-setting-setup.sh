#!/usr/bin/env bash
# Introspection SETUP: set a distinctive value in site_audit_report_entity.settings 'example'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("site_audit_report_entity.settings")->set("example","SARE_setting_9x")->save();
' >/dev/null 2>&1
echo "setup: site_audit_report_entity.settings example = SARE_setting_9x"
