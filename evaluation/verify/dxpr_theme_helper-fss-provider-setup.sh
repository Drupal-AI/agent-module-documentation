#!/usr/bin/env bash
# Introspection SETUP: place a DXPR Full Screen Search block (dth_fss_prov) configured to use
# Core Search with a distinctive search_parameter, so an agent can report the provider/param.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("dth_fss_prov")) { $b->delete(); }
  Block::create([
    "id"=>"dth_fss_prov","theme"=>"olivero","region"=>"content","plugin"=>"full_screen_search",
    "settings"=>["id"=>"full_screen_search","label"=>"DTH Prov Search","label_display"=>"0",
      "search_provider"=>"core","search_url"=>"/search","search_parameter"=>"keys"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block dth_fss_prov (full_screen_search) provider=core parameter=keys"
