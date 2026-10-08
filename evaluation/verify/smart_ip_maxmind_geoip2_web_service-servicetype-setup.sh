#!/usr/bin/env bash
# Introspection SETUP (smart_ip_maxmind_geoip2_web_service M): set a known service_type (insights)
# so the agent must read the live config to report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset smart_ip_maxmind_geoip2_web_service.settings service_type insights -y >/dev/null 2>&1
echo "setup: smart_ip_maxmind_geoip2_web_service.settings:service_type = insights"
