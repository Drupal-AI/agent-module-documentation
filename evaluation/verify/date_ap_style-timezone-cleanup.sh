#!/usr/bin/env bash
# Introspection CLEANUP: restore date_ap_style.settings shipped defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("date_ap_style.settings")->setData(["always_display_year"=>false,"use_today"=>false,"cap_today"=>false,"display_day"=>false,"display_time"=>false,"hide_date"=>false,"time_before_date"=>false,"display_noon_and_midnight"=>false,"capitalize_noon_and_midnight"=>false,"use_all_day"=>false,"separator"=>"to","timezone"=>"","month_only"=>false])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: date_ap_style.settings restored to defaults"
