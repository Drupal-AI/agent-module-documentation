#!/usr/bin/env bash
# Introspection SETUP: create an image style that uses the quality effect so an agent can name it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $s = ImageStyle::load("isq_named_style") ?: ImageStyle::create(["name"=>"isq_named_style","label"=>"ISQ Named Style"]);
  foreach ($s->getEffects() as $e) { if ($e->getPluginId()==="image_style_quality") { $s->deleteImageEffect($e); } }
  $s->addImageEffect(["id"=>"image_scale","weight"=>1,"data"=>["width"=>300,"height"=>300,"upscale"=>FALSE]]);
  $s->addImageEffect(["id"=>"image_style_quality","weight"=>10,"data"=>["quality"=>70]]);
  $s->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: image style isq_named_style uses image_style_quality effect"
