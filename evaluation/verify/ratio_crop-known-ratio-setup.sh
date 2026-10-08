#!/usr/bin/env bash
# Introspection SETUP: create image style ratiocrop_known with a ratio_crop effect
# (aspect_ratio 4:3, anchor left-top) so an agent can read the ratio back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("ratiocrop_known")) { $s->delete(); }
  $s = ImageStyle::create(["name" => "ratiocrop_known", "label" => "Ratiocrop Known"]);
  $s->addImageEffect(["id" => "image_crop_ratio", "data" => ["aspect_ratio" => "4:3", "anchor" => "left-top"]]);
  $s->save();
' >/dev/null 2>&1
echo "setup: image.style.ratiocrop_known has image_crop_ratio aspect_ratio=4:3 anchor=left-top"
