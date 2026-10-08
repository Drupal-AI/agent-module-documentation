#!/usr/bin/env bash
# Execution RESET for "enable inline image resizing on a text format".
# Rebuilds mdir_enable_format with filter_html + media_embed (weight 10) but NO resize
# filter, and ensures a 400x400 source image at public://mdir-enable/banner.png. Clears
# public://resize. Verify FAILS on this state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\Core\File\FileSystemInterface;
  use Drupal\filter\Entity\FilterFormat;

  $id = "mdir_enable_format";
  if ($f = FilterFormat::load($id)) { $f->delete(); }
  $format = FilterFormat::create(["format" => $id, "name" => "MDIR enable format", "weight" => 57]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE, "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <img src width height alt> <drupal-media data-entity-type data-entity-uuid>"],
  ]);
  $format->setFilterConfig("media_embed", ["status" => TRUE, "weight" => 10, "settings" => []]);
  $format->save();

  $fs = \Drupal::service("file_system");
  $fs->deleteRecursive("public://resize");
  $dir = "public://mdir-enable";
  $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY);
  $uri = "public://mdir-enable/banner.png";
  if (!file_exists($uri)) {
    $im = imagecreatetruecolor(400, 400);
    $tmp = $fs->tempnam("temporary://", "mdiren");
    imagepng($im, $fs->realpath($tmp));
    $fs->move($tmp, $uri, \Drupal\Core\File\FileExists::Replace);
  }
' >/dev/null 2>&1

echo "reset: mdir_enable_format without the resize filter; public://mdir-enable/banner.png is 400x400"
