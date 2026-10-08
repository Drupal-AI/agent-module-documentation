#!/usr/bin/env bash
# Execution RESET for "warm derivatives": ensure image style isg_gen and a published source
# image (public://isg_warm_src.png) exist, and DELETE any existing derivative so verify FAILS
# on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  use Drupal\file\Entity\File;
  $fs = \Drupal::service("file_system");
  if (!ImageStyle::load("isg_gen")) {
    $s = ImageStyle::create(["name" => "isg_gen", "label" => "ISG Gen"]);
    $s->addImageEffect(["id" => "image_scale", "data" => ["width" => 50, "height" => 50, "upscale" => FALSE]]);
    $s->save();
  }
  $base = $fs->realpath("public://");
  $img = $base . "/isg_warm_src.png";
  if (!file_exists($img)) {
    $im = imagecreatetruecolor(60, 40);
    imagefilledrectangle($im, 0, 0, 60, 40, imagecolorallocate($im, 120, 120, 120));
    imagepng($im, $img);
    imagedestroy($im);
  }
  $existing = \Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => "public://isg_warm_src.png"]);
  if (!$existing) {
    File::create(["uri" => "public://isg_warm_src.png", "filename" => "isg_warm_src.png", "filemime" => "image/png", "status" => 1])->save();
  }
  $style = ImageStyle::load("isg_gen");
  $deriv = $style->buildUri("public://isg_warm_src.png");
  if (file_exists($deriv)) { $fs->delete($deriv); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: isg_gen style + published isg_warm_src.png present, derivative cleared"
