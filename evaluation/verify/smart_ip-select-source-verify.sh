#!/usr/bin/env bash
# Execution VERIFY (smart_ip H1): PASS when the agent has selected the MaxMind GeoIP2 binary
# database source, i.e. smart_ip.settings:data_source == 'maxmind_geoip2_bin_db'. exit 0/1.
set -uo pipefail
cd /var/www/html
val="$(drush php:eval 'echo (string) \Drupal::config("smart_ip.settings")->get("data_source");' 2>/dev/null | tr -d '[:space:]')"
if [ "$val" = "maxmind_geoip2_bin_db" ]; then
  echo "PASS: smart_ip data_source is maxmind_geoip2_bin_db"
  exit 0
fi
echo "FAIL: smart_ip data_source is not maxmind_geoip2_bin_db (got '$val')"
exit 1
