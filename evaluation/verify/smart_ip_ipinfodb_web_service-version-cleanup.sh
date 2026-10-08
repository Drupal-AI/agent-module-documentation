#!/usr/bin/env bash
# Introspection CLEANUP (smart_ip_ipinfodb_web_service M): restore shipped default version=3. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("smart_ip_ipinfodb_web_service.settings")->set("version", 3)->save();' >/dev/null 2>&1
echo "cleanup: smart_ip_ipinfodb_web_service.settings:version restored to 3"
