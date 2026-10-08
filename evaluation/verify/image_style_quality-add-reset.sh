#!/usr/bin/env bash
# Execution RESET: create image style isq_task_style WITHOUT the quality effect (just a scale) so
# verify fails until the agent adds image_style_quality. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("isq_task_style")) { $s->delete(); }
  $s = ImageStyle::create(["name"=>"isq_task_style","label"=>"ISQ Task Style"]);
  $s->addImageEffect(["id"=>"image_scale","weight"=>1,"data"=>["width"=>200,"height"=>200,"upscale"=>FALSE]]);
  $s->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: image style isq_task_style created without quality effect"
