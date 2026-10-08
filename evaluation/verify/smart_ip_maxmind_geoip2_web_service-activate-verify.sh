#!/usr/bin/env bash
# Execution VERIFY (smart_ip_maxmind_geoip2_web_service H): PASS when this source is selected, i.e.
# smart_ip.settings:data_source == 'maxmind_geoip2_web_service'. exit 0/1.
set -uo pipefail
cd /var/www/html
val="$(drush php:eval 'echo (string) \Drupal::config("smart_ip.settings")->get("data_source");' 2>/dev/null | tr -d '[:space:]')"
if [ "$val" = "maxmind_geoip2_web_service" ]; then
  echo "PASS: data_source is maxmind_geoip2_web_service"
  exit 0
fi
echo "FAIL: data_source is not maxmind_geoip2_web_service (got '$val')"
exit 1
