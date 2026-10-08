#!/usr/bin/env bash
# Execution VERIFY: PASS when 198.51.100.7 is present in spambot_whitelist_ip_list. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$l=\Drupal::config("spambot.settings")->get("spambot_whitelist_ip_list"); $l=is_array($l)?$l:[]; print (in_array("198.51.100.7",$l,TRUE)?"PASS":"FAIL")." list=".implode(",",$l)."\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
