#!/usr/bin/env bash
# Execution RESET for the WebP warm case: ensure the submodule is enabled, an image style
# isg_webp and a published source image public://isg_wsrc.png exist, and DELETE any existing
# derivative and its .webp copy so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install image_styles_generator_webp -y >/dev/null 2>&1
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  use Drupal\file\Entity\File;
  $fs = \Drupal::service("file_system");
  if (!ImageStyle::load("isg_webp")) {
    $s = ImageStyle::create(["name" => "isg_webp", "label" => "ISG WebP"]);
    $s->addImageEffect(["id" => "image_scale", "data" => ["width" => 48, "height" => 48, "upscale" => FALSE]]);
    $s->save();
  }
  $base = $fs->realpath("public://");
  $img = $base . "/isg_wsrc.png";
  if (!file_exists($img)) {
    $im = imagecreatetruecolor(64, 48);
    imagefilledrectangle($im, 0, 0, 64, 48, imagecolorallocate($im, 70, 140, 210));
    imagepng($im, $img);
    imagedestroy($im);
  }
  $existing = \Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => "public://isg_wsrc.png"]);
  if (!$existing) {
    File::create(["uri" => "public://isg_wsrc.png", "filename" => "isg_wsrc.png", "filemime" => "image/png", "status" => 1])->save();
  }
  $style = ImageStyle::load("isg_webp");
  $deriv = $style->buildUri("public://isg_wsrc.png");
  $webp = $style->buildUri("public://isg_wsrc.png");
  $webp = preg_replace("/\\.png$/", ".webp", $deriv);
  if (file_exists($deriv)) { $fs->delete($deriv); }
  if (file_exists($webp)) { $fs->delete($webp); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: isg_webp style + published isg_wsrc.png present, derivative and .webp cleared"
