#!/usr/bin/env bash
# Introspection SETUP: place a Facets Block 'fb_known' configured to include two facets.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("fb_known")) { $b->delete(); }
  Block::create([
    "id"=>"fb_known","theme"=>$theme,"region"=>"content","plugin"=>"facets_block","weight"=>0,
    "settings"=>["id"=>"facets_block","label"=>"Filters","label_display"=>"visible","show_title"=>TRUE,"exclude_empty_facets"=>TRUE,"hide_empty_block"=>FALSE,"add_js_classes"=>FALSE,"facets_to_include"=>["facet_block:brand","facet_block:color"]],
    "visibility"=>[],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block fb_known includes facet_block:brand and facet_block:color"
