#!/usr/bin/env bash
# Execution RESET: place a Hierarchical Taxonomy Menu block htm_task with collapsible = FALSE, so
# verify FAILS until the agent makes the menu collapsible by default.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("htm_task")) { $b->delete(); }
' >/dev/null 2>&1
drush php:eval '
  use Drupal\block\Entity\Block;
  Block::create([
    "id"=>"htm_task","theme"=>"olivero","region"=>"content","weight"=>0,"plugin"=>"hierarchical_taxonomy_menu",
    "settings"=>["id"=>"hierarchical_taxonomy_menu","label"=>"Categories","label_display"=>"visible","provider"=>"hierarchical_taxonomy_menu","vocabulary"=>"tags","max_depth"=>100,"collapsible"=>FALSE],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block htm_task collapsible=false"
