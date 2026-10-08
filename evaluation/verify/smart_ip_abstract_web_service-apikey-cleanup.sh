#!/usr/bin/env bash
# Introspection CLEANUP (smart_ip_abstract_web_service M): restore shipped default api_key=null. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("smart_ip_abstract_web_service.settings")->set("api_key", NULL)->save();' >/dev/null 2>&1
echo "cleanup: smart_ip_abstract_web_service.settings:api_key restored to null"
