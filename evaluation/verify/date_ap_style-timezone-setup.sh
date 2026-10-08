#!/usr/bin/env bash
# Introspection SETUP: set a distinctive global timezone override so an agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("date_ap_style.settings")->setData(["always_display_year"=>false,"use_today"=>false,"cap_today"=>false,"display_day"=>false,"display_time"=>false,"hide_date"=>false,"time_before_date"=>false,"display_noon_and_midnight"=>false,"capitalize_noon_and_midnight"=>false,"use_all_day"=>false,"separator"=>"to","timezone"=>"","month_only"=>false])->save(); \Drupal::configFactory()->getEditable("date_ap_style.settings")->set("timezone","America/Chicago")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: date_ap_style.settings timezone=America/Chicago"
