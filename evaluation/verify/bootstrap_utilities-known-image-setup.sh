#!/usr/bin/env bash
# Introspection SETUP: text format buty_img with the image filter enabled.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f=FilterFormat::load("buty_img"); if(!$f){$f=FilterFormat::create(["format"=>"buty_img","name"=>"BUTY Img","weight"=>42]);}
  $f->setFilterConfig("bootstrap_utilities_image_filter",["status"=>TRUE,"weight"=>10,"settings"=>[]]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format buty_img has bootstrap_utilities_image_filter enabled"
