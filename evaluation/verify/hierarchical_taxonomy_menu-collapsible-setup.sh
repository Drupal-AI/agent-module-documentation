#!/usr/bin/env bash
# Introspection SETUP: place a Hierarchical Taxonomy Menu block that is collapsible by default,
# so an agent can read the 'collapsible' block setting.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if (!Block::load("htm_med_collapse")) {
    Block::create([
      "id"=>"htm_med_collapse","theme"=>"olivero","region"=>"content","weight"=>0,"plugin"=>"hierarchical_taxonomy_menu",
      "settings"=>["id"=>"hierarchical_taxonomy_menu","label"=>"Categories","label_display"=>"visible","provider"=>"hierarchical_taxonomy_menu","vocabulary"=>"tags","max_depth"=>100,"collapsible"=>TRUE,"stay_open"=>TRUE],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block htm_med_collapse collapsible=true"
