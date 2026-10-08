#!/usr/bin/env bash
# Introspection SETUP: create a known image style rsw_eval_style (image_scale, width 320) so the
# agent can be asked what derivative URI remote_stream_wrapper's ImageStyle override produces
# for a remote original on THIS site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("rsw_eval_style")) { $s->delete(); }
  $s = ImageStyle::create(["name" => "rsw_eval_style", "label" => "RSW Eval Style"]);
  $s->addImageEffect(["id" => "image_scale", "data" => ["width" => 320, "height" => NULL, "upscale" => FALSE]]);
  $s->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: image style rsw_eval_style created (image_scale width 320)"
