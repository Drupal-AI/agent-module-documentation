#!/usr/bin/env bash
# Introspection SETUP: create image style ratiocrop_anchor with a ratio_crop effect
# (aspect_ratio 3:2, anchor right-bottom) so an agent can read the anchor back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("ratiocrop_anchor")) { $s->delete(); }
  $s = ImageStyle::create(["name" => "ratiocrop_anchor", "label" => "Ratiocrop Anchor"]);
  $s->addImageEffect(["id" => "image_crop_ratio", "data" => ["aspect_ratio" => "3:2", "anchor" => "right-bottom"]]);
  $s->save();
' >/dev/null 2>&1
echo "setup: image.style.ratiocrop_anchor has image_crop_ratio anchor=right-bottom"
