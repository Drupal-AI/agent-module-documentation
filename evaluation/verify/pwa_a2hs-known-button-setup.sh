#!/usr/bin/env bash
# Introspection SETUP: place A2HS block 'pwa_a2hs_probe' with button_text 'Get the App'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("pwa_a2hs_probe")) { $b->delete(); }
  Block::create(["id"=>"pwa_a2hs_probe","plugin"=>"pwa_add_to_home_screen","theme"=>$theme,"region"=>"content","weight"=>0,
    "settings"=>["id"=>"pwa_add_to_home_screen","label"=>"A2HS Probe","label_display"=>"0","provider"=>"pwa_a2hs","button_text"=>"Get the App"]])->save();
' >/dev/null 2>&1
echo "setup: block pwa_a2hs_probe button_text='Get the App'"
