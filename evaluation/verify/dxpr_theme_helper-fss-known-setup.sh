#!/usr/bin/env bash
# Introspection SETUP: place the DXPR Theme Full Screen Search block (dth_fss_known) in olivero
# configured for the Search API provider with a known search_url, so an agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("dth_fss_known")) { $b->delete(); }
  Block::create([
    "id"=>"dth_fss_known","theme"=>"olivero","region"=>"content","plugin"=>"full_screen_search",
    "settings"=>["id"=>"full_screen_search","label"=>"DTH Known Search","label_display"=>"0",
      "search_provider"=>"search_api","search_url"=>"/dth-known-search","search_parameter"=>"dth_fulltext"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block dth_fss_known (full_screen_search) search_url=/dth-known-search"
