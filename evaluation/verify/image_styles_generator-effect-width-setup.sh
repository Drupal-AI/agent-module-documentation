#!/usr/bin/env bash
# Introspection SETUP: create image style isg_effect with an image_scale effect of width 321,
# so an agent can inspect the live image_style config and report the width. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("isg_effect")) { $s->delete(); }
  $s = ImageStyle::create(["name" => "isg_effect", "label" => "ISG Effect"]);
  $s->addImageEffect(["id" => "image_scale", "data" => ["width" => 321, "height" => 200, "upscale" => FALSE]]);
  $s->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: image style isg_effect has an image_scale effect width=321"
