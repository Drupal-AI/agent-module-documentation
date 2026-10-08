#!/usr/bin/env bash
# Introspection SETUP: create text format mfl_eval_format with the "Media file link" filter
# enabled and a distinctive custom template + icon setting, plus a document media item
# "MFL doc media" backed by a real .txt file. The agent must read the live filter settings
# (and can run the filter) to answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\filter\Entity\FilterFormat;

  $id = "mfl_eval_format";
  $format = FilterFormat::load($id) ?: FilterFormat::create(["format" => $id, "name" => "MFL eval format", "weight" => 62]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE, "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <span class data-file-type> <a href download> <drupal-media-file-link data-entity-uuid data-entity-type data-file-type>"],
  ]);
  $format->setFilterConfig("media_directories_file_link", [
    "status" => TRUE, "weight" => 90,
    "settings" => [
      "template" => "<a href=\"@file_url\" download>@name — @size (@file_type)</a>",
      "icon" => FALSE,
    ],
  ]);
  $format->save();

  $storage = \Drupal::entityTypeManager()->getStorage("media");
  if (!$storage->loadByProperties(["name" => "MFL doc media"])) {
    $fs = \Drupal::service("file_system");
    $dir = "public://mfl";
    $fs->prepareDirectory($dir, \Drupal\Core\File\FileSystemInterface::CREATE_DIRECTORY);
    $uri = $dir . "/report.txt";
    if (!file_exists($uri)) { $fs->saveData("MFL eval report body", $uri, \Drupal\Core\File\FileExists::Replace); }
    $file = \Drupal\file\Entity\File::create(["uri" => $uri, "status" => 1]);
    $file->save();
    \Drupal\media\Entity\Media::create([
      "bundle" => "document", "name" => "MFL doc media", "status" => 1,
      "field_media_document" => ["target_id" => $file->id()],
    ])->save();
  }

' >/dev/null 2>&1

echo "setup: mfl_eval_format template='<a href=\"@file_url\" download>@name — @size (@file_type)</a>' icon=FALSE; media 'MFL doc media' present"
