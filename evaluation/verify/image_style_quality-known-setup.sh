#!/usr/bin/env bash
# Introspection SETUP: create an image style with an image_style_quality effect at a known quality
# so an agent can read the configured quality back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $s = ImageStyle::load("isq_probe_style") ?: ImageStyle::create(["name"=>"isq_probe_style","label"=>"ISQ Probe Style"]);
  foreach ($s->getEffects() as $e) { if ($e->getPluginId()==="image_style_quality") { $s->deleteImageEffect($e); } }
  $s->addImageEffect(["id"=>"image_style_quality","weight"=>10,"data"=>["quality"=>42]]);
  $s->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: image style isq_probe_style has image_style_quality effect quality=42"
