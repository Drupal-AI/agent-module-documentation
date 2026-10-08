#!/usr/bin/env bash
# Execution RESET: create isq_mod_style WITH the quality effect at 90 (verify wants 60). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("isq_mod_style")) { $s->delete(); }
  $s = ImageStyle::create(["name"=>"isq_mod_style","label"=>"ISQ Mod Style"]);
  $s->addImageEffect(["id"=>"image_style_quality","weight"=>10,"data"=>["quality"=>90]]);
  $s->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: image style isq_mod_style has quality effect at 90"
