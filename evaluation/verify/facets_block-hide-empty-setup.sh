#!/usr/bin/env bash
# Introspection SETUP: two Facets Blocks, fb_a (hide_empty_block true) and fb_b (false).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  foreach (["fb_a"=>TRUE,"fb_b"=>FALSE] as $id=>$hide) {
    if ($b = Block::load($id)) { $b->delete(); }
    Block::create([
      "id"=>$id,"theme"=>$theme,"region"=>"content","plugin"=>"facets_block","weight"=>0,
      "settings"=>["id"=>"facets_block","label"=>$id,"label_display"=>"visible","show_title"=>TRUE,"exclude_empty_facets"=>TRUE,"hide_empty_block"=>$hide,"add_js_classes"=>FALSE,"facets_to_include"=>[]],
      "visibility"=>[],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: fb_a hide_empty_block=true, fb_b hide_empty_block=false"
