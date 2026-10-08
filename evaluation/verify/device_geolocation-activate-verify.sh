#!/usr/bin/env bash
# Execution VERIFY (device_geolocation H1): PASS when device_geolocation is selected as the Smart IP
# data source, i.e. smart_ip.settings:data_source == 'device_geolocation'. exit 0/1.
set -uo pipefail
cd /var/www/html
val="$(drush php:eval 'echo (string) \Drupal::config("smart_ip.settings")->get("data_source");' 2>/dev/null | tr -d '[:space:]')"
if [ "$val" = "device_geolocation" ]; then
  echo "PASS: data_source is device_geolocation"
  exit 0
fi
echo "FAIL: data_source is not device_geolocation (got '$val')"
exit 1
