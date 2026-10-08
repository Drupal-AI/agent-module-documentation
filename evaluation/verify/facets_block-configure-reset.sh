#!/usr/bin/env bash
# Execution RESET: place block fb_conf (facets_block) with add_js_classes=FALSE and
# hide_empty_block=FALSE, so verify FAILS until the agent enables both.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("fb_conf")) { $b->delete(); }
  Block::create([
    "id"=>"fb_conf","theme"=>$theme,"region"=>"content","plugin"=>"facets_block","weight"=>0,
    "settings"=>["id"=>"facets_block","label"=>"Facets","label_display"=>"visible","show_title"=>TRUE,"exclude_empty_facets"=>TRUE,"hide_empty_block"=>FALSE,"add_js_classes"=>FALSE,"facets_to_include"=>[]],
    "visibility"=>[],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block fb_conf placed with add_js_classes=FALSE, hide_empty_block=FALSE"
