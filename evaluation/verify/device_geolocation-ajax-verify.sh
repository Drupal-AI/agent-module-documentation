#!/usr/bin/env bash
# Execution VERIFY (device_geolocation H2): PASS when AJAX geolocation checking has been enabled, i.e.
# device_geolocation.settings:use_ajax_check == true. exit 0/1.
set -uo pipefail
cd /var/www/html
val="$(drush php:eval '$v=\Drupal::config("device_geolocation.settings")->get("use_ajax_check"); echo $v?"1":"0";' 2>/dev/null | tr -d '[:space:]')"
if [ "$val" = "1" ]; then
  echo "PASS: use_ajax_check is enabled (true)"
  exit 0
fi
echo "FAIL: use_ajax_check is not enabled (got '$val')"
exit 1
