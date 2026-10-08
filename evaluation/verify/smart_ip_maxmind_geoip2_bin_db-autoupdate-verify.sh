#!/usr/bin/env bash
# Execution VERIFY (smart_ip_maxmind_geoip2_bin_db H): PASS when db_auto_update has been turned OFF (false). exit 0/1.
set -uo pipefail
cd /var/www/html
val="$(drush php:eval '$v=\Drupal::config("smart_ip_maxmind_geoip2_bin_db.settings")->get("db_auto_update"); echo $v?"1":"0";' 2>/dev/null | tr -d '[:space:]')"
if [ "$val" = "0" ]; then
  echo "PASS: db_auto_update is disabled (false)"
  exit 0
fi
echo "FAIL: db_auto_update is not disabled (got '$val')"
exit 1
