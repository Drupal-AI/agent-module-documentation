#!/usr/bin/env bash
# Introspection SETUP: create text format mdir_eval_svg with the "Resize images" filter
# enabled, and place two files in public://mdir-eval-svg/: photo.png (200x200 raster) and
# logo.svg (a vector). The agent must run the live filter to see which one is rewritten.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\Core\File\FileSystemInterface;
  use Drupal\filter\Entity\FilterFormat;

  $id = "mdir_eval_svg";
  $format = FilterFormat::load($id) ?: FilterFormat::create(["format" => $id, "name" => "MDIR eval svg", "weight" => 56]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE, "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <img src width height alt>"],
  ]);
  $format->setFilterConfig("media_directories_image_resize", ["status" => TRUE, "weight" => 50, "settings" => []]);
  $format->save();

  $fs = \Drupal::service("file_system");
  $dir = "public://mdir-eval-svg";
  $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY);

  $png = "public://mdir-eval-svg/photo.png";
  if (!file_exists($png)) {
    $im = imagecreatetruecolor(200, 200);
    $tmp = $fs->tempnam("temporary://", "mdirsvg");
    imagepng($im, $fs->realpath($tmp));
    $fs->move($tmp, $png, \Drupal\Core\File\FileExists::Replace);
  }
  $svg = "public://mdir-eval-svg/logo.svg";
  if (!file_exists($svg)) {
    $fs->saveData("<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"200\" height=\"200\"><rect fill=\"red\" width=\"200\" height=\"200\"/></svg>", $svg, \Drupal\Core\File\FileExists::Replace);
  }
' >/dev/null 2>&1

echo "setup: mdir_eval_svg format + public://mdir-eval-svg/{photo.png,logo.svg}"
