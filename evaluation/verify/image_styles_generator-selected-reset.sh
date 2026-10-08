#!/usr/bin/env bash
# Execution RESET for "warm only a selected style": ensure styles isg_sela and isg_selb and a
# published source image (public://isg_sel_src.png) exist, and DELETE both derivatives so
# verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  use Drupal\file\Entity\File;
  $fs = \Drupal::service("file_system");
  foreach (["isg_sela" => "ISG Sel A", "isg_selb" => "ISG Sel B"] as $name => $label) {
    if (!ImageStyle::load($name)) {
      $s = ImageStyle::create(["name" => $name, "label" => $label]);
      $s->addImageEffect(["id" => "image_scale", "data" => ["width" => 40, "height" => 40, "upscale" => FALSE]]);
      $s->save();
    }
  }
  $base = $fs->realpath("public://");
  $img = $base . "/isg_sel_src.png";
  if (!file_exists($img)) {
    $im = imagecreatetruecolor(60, 40);
    imagefilledrectangle($im, 0, 0, 60, 40, imagecolorallocate($im, 90, 90, 90));
    imagepng($im, $img);
    imagedestroy($im);
  }
  $existing = \Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => "public://isg_sel_src.png"]);
  if (!$existing) {
    File::create(["uri" => "public://isg_sel_src.png", "filename" => "isg_sel_src.png", "filemime" => "image/png", "status" => 1])->save();
  }
  foreach (["isg_sela", "isg_selb"] as $name) {
    $style = ImageStyle::load($name);
    $deriv = $style->buildUri("public://isg_sel_src.png");
    if (file_exists($deriv)) { $fs->delete($deriv); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: isg_sela + isg_selb styles + published isg_sel_src.png present, both derivatives cleared"
