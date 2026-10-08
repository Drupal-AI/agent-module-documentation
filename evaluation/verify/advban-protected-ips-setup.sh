#!/usr/bin/env bash
# Introspection SETUP: write a known advban.settings config — a protected IP list containing
# a CIDR block, a crawler host suffix and a comment, plus a non-default expiry duration.
# advban ships no config/install file, so this creates the object. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("advban.settings")
    ->set("expiry_durations", "+1 hour\n+1 day\n+3 days\n+1 week\n+1 month\n+1 year")
    ->set("default_expiry_duration", "+3 days")
    ->set("save_last_expiry_duration", FALSE)
    ->set("advban_listing_table_rows", "50")
    ->set("range_ip_format", "@ip_start ... @ip_end")
    ->set("advban_ban_text", "@ip has been banned")
    ->set("advban_ban_expire_text", "@ip has been banned up to @expiry_date")
    ->set("advban_protected_ips", "# advban eval protected list\n198.51.100.0/24\ngooglebot.com")
    ->save();
' >/dev/null 2>&1
echo "setup: advban.settings written (protected 198.51.100.0/24 + googlebot.com, default duration +3 days)"
