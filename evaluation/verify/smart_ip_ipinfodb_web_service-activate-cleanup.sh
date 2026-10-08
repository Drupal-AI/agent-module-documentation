#!/usr/bin/env bash
# Execution CLEANUP (smart_ip_ipinfodb_web_service H): restore shipped default data_source=null. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("smart_ip.settings")->set("data_source", NULL)->save();' >/dev/null 2>&1
echo "cleanup: smart_ip.settings:data_source restored to null"
