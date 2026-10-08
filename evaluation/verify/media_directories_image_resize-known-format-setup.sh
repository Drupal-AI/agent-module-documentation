#!/usr/bin/env bash
# Introspection SETUP: create text format mdir_eval_format with the "Resize images" filter
# (media_directories_image_resize) enabled at weight 50, ordered AFTER media_embed (weight
# 10), and place a real 200x200 PNG at public://mdir-eval/source.png so the agent can run the
# filter against the live site. Namespaced to this module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\Core\File\FileSystemInterface;
  use Drupal\filter\Entity\FilterFormat;

  $id = "mdir_eval_format";
  $format = FilterFormat::load($id) ?: FilterFormat::create(["format" => $id, "name" => "MDIR eval format", "weight" => 54]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE, "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <img src width height alt>"],
  ]);
  $format->setFilterConfig("media_embed", ["status" => TRUE, "weight" => 10, "settings" => []]);
  $format->setFilterConfig("media_directories_image_resize", ["status" => TRUE, "weight" => 50, "settings" => []]);
  $format->save();

  $fs = \Drupal::service("file_system");
  $dir = "public://mdir-eval";
  $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY);
  $uri = "public://mdir-eval/source.png";
  if (!file_exists($uri)) {
    $im = imagecreatetruecolor(200, 200);
    $tmp = $fs->tempnam("temporary://", "mdir");
    imagepng($im, $fs->realpath($tmp));
    $fs->move($tmp, $uri, \Drupal\Core\File\FileExists::Replace);
  }
' >/dev/null 2>&1

echo "setup: mdir_eval_format has media_directories_image_resize at weight 50; public://mdir-eval/source.png is 200x200"
