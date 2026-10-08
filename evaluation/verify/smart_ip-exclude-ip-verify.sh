#!/usr/bin/env bash
# Execution VERIFY (smart_ip H2): PASS when the agent has added the IP 198.51.100.7 to
# smart_ip.settings:excluded_ips so it is skipped from geolocation. exit 0/1.
set -uo pipefail
cd /var/www/html
has="$(drush php:eval '$v=(string)\Drupal::config("smart_ip.settings")->get("excluded_ips"); echo (strpos($v,"198.51.100.7")!==FALSE)?"yes":"no";' 2>/dev/null | tr -d '[:space:]')"
if [ "$has" = "yes" ]; then
  echo "PASS: 198.51.100.7 is present in smart_ip excluded_ips"
  exit 0
fi
echo "FAIL: 198.51.100.7 not found in smart_ip excluded_ips"
exit 1
