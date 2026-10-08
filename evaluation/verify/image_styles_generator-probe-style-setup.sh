#!/usr/bin/env bash
# Introspection SETUP: create an image style isg_probe (label "ISG Probe") so an inspecting
# agent can read it back from live image_style config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if (!ImageStyle::load("isg_probe")) {
    $s = ImageStyle::create(["name" => "isg_probe", "label" => "ISG Probe"]);
    $s->addImageEffect(["id" => "image_scale", "data" => ["width" => 123, "height" => 90, "upscale" => FALSE]]);
    $s->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: image style isg_probe (label 'ISG Probe', scale width 123) present"
