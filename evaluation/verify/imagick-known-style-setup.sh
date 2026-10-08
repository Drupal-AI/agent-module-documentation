#!/usr/bin/env bash
# Introspection SETUP: create an image style imagick_known that applies the Imagick blur
# effect (image_blur) with a known radius (8) and gaussian type, so an inspecting agent can
# read back which effect/radius is configured. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("image_style");
  if ($s = $storage->load("imagick_known")) { $s->delete(); }
  $style = $storage->create(["name" => "imagick_known", "label" => "Imagick Known"]);
  $style->addImageEffect(["id" => "image_blur", "weight" => 1, "data" => ["type" => 2, "radius" => "8", "sigma" => "4", "angle" => "0"]]);
  $style->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: image style imagick_known has effect image_blur (radius 8)"
