#!/usr/bin/env bash
# Execution RESET: place block 'pwa_a2hs_switch' with default button_text 'Install app' so verify
# FAILS until the agent changes it to 'Add to phone'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("pwa_a2hs_switch")) { $b->delete(); }
  Block::create(["id"=>"pwa_a2hs_switch","plugin"=>"pwa_add_to_home_screen","theme"=>$theme,"region"=>"content","weight"=>0,
    "settings"=>["id"=>"pwa_add_to_home_screen","label"=>"A2HS Switch","label_display"=>"0","provider"=>"pwa_a2hs","button_text"=>"Install app"]])->save();
' >/dev/null 2>&1
echo "reset: block pwa_a2hs_switch button_text='Install app'"
