#!/usr/bin/env bash
# Introspection SETUP: place the Last Updated date block (updated_date_block) in the default
# theme with a known date_prefix "Revised on", so the agent can read its configured prefix.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("updated_med")) { $b->delete(); }
  Block::create([
    "id"=>"updated_med","theme"=>$theme,"plugin"=>"updated_date_block","region"=>"content","weight"=>0,
    "settings"=>["id"=>"updated_date_block","label"=>"Last Updated","label_display"=>"0","date_prefix"=>"Revised on","date_format"=>"custom","custom_date_format"=>"F j, Y g:ia","timezone"=>""],
    "visibility"=>[],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block updated_med (updated_date_block) placed with date_prefix 'Revised on'"
