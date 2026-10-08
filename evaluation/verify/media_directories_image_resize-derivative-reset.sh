#!/usr/bin/env bash
# Execution RESET for "generate a resized derivative".
# Rebuilds the mdir_task_format text format WITHOUT the resize filter, ensures a 300x300
# source image at public://mdir-task/hero.png, and deletes public://resize entirely so verify
# FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\Core\File\FileSystemInterface;
  use Drupal\filter\Entity\FilterFormat;

  $id = "mdir_task_format";
  if ($f = FilterFormat::load($id)) { $f->delete(); }
  $format = FilterFormat::create(["format" => $id, "name" => "MDIR task format", "weight" => 55]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE, "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <img src width height alt>"],
  ]);
  $format->save();

  $fs = \Drupal::service("file_system");
  $fs->deleteRecursive("public://resize");
  $dir = "public://mdir-task";
  $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY);
  $uri = "public://mdir-task/hero.png";
  if (!file_exists($uri)) {
    $im = imagecreatetruecolor(300, 300);
    $tmp = $fs->tempnam("temporary://", "mdirtask");
    imagepng($im, $fs->realpath($tmp));
    $fs->move($tmp, $uri, \Drupal\Core\File\FileExists::Replace);
  }
' >/dev/null 2>&1

echo "reset: mdir_task_format has no resize filter; public://resize cleared; public://mdir-task/hero.png is 300x300"
