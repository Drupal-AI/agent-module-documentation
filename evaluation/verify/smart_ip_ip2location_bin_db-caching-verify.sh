#!/usr/bin/env bash
# Execution VERIFY (smart_ip_ip2location_bin_db H): PASS when caching_method is set to shared_memory. exit 0/1.
set -uo pipefail
cd /var/www/html
val="$(drush php:eval 'echo (string) \Drupal::config("smart_ip_ip2location_bin_db.settings")->get("caching_method");' 2>/dev/null | tr -d '[:space:]')"
if [ "$val" = "shared_memory" ]; then
  echo "PASS: caching_method is shared_memory"
  exit 0
fi
echo "FAIL: caching_method is not shared_memory (got '$val')"
exit 1
