#!/usr/bin/env bash
# Introspection SETUP: create two generated-style image styles (responsive_320w, responsive_640w)
# exactly as the module would (image_scale, flexible height). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  foreach ([320, 640] as $w) {
    $name = "responsive_${w}w";
    if (!ImageStyle::load($name)) {
      $s = ImageStyle::create(["name" => $name, "label" => $name]);
      $s->addImageEffect(["id" => "image_scale", "data" => ["width" => $w, "height" => NULL, "upscale" => TRUE]]);
      $s->save();
    }
  }
' >/dev/null 2>&1
echo "setup: image styles responsive_320w, responsive_640w created"
