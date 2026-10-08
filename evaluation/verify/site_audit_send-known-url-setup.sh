#!/usr/bin/env bash
# Introspection SETUP: set a distinctive remote_url in site_audit_send.settings. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("site_audit_send.settings")
    ->set("remote_url","https://sas-known.example.com/api/site-audit")->save();
' >/dev/null 2>&1
echo "setup: site_audit_send.settings remote_url = https://sas-known.example.com/api/site-audit"
