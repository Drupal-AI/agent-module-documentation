#!/usr/bin/env bash
# next introspection SETUP: create next_site nextzz_known with a known base_url.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\next\Entity\NextSite;
  if ($s = NextSite::load("nextzz_known")) { $s->delete(); }
  NextSite::create([
    "id" => "nextzz_known", "label" => "Known Site",
    "base_url" => "https://known.example.com",
    "preview_url" => "https://known.example.com/api/preview",
    "preview_secret" => "knownsecret",
    "revalidate_url" => "https://known.example.com/api/revalidate",
    "revalidate_secret" => "knownsecret",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: next_site nextzz_known base_url=https://known.example.com"
