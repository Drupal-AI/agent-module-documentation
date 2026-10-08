#!/usr/bin/env bash
# Introspection CLEANUP (smart_ip_maxmind_geoip2_web_service M): restore shipped default service_type city. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset smart_ip_maxmind_geoip2_web_service.settings service_type city -y >/dev/null 2>&1
echo "cleanup: smart_ip_maxmind_geoip2_web_service.settings:service_type restored to city"
