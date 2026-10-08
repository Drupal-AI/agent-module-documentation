#!/usr/bin/env bash
# Introspection SETUP: place a Hierarchical Taxonomy Menu block built from a known vocabulary
# (tags), so an agent can read which vocabulary the block uses. Block placed in olivero theme.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if (!Block::load("htm_med_vocab")) {
    Block::create([
      "id"=>"htm_med_vocab","theme"=>"olivero","region"=>"content","weight"=>0,"plugin"=>"hierarchical_taxonomy_menu",
      "settings"=>["id"=>"hierarchical_taxonomy_menu","label"=>"Categories","label_display"=>"visible","provider"=>"hierarchical_taxonomy_menu","vocabulary"=>"tags","max_depth"=>3,"collapsible"=>FALSE],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block htm_med_vocab vocabulary=tags"
