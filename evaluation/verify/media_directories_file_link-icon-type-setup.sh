#!/usr/bin/env bash
# Introspection SETUP: create text format mfl_icon_format with the "Media file link" filter
# enabled, the DEFAULT template and icon = TRUE, plus a document media item "MFL zip media"
# backed by a real .zip file. The agent must run the live filter to see the file-type
# category the wrapper gets. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\Core\File\FileExists;
  use Drupal\Core\File\FileSystemInterface;
  use Drupal\file\Entity\File;
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\media\Entity\Media;

  $id = "mfl_icon_format";
  $format = FilterFormat::load($id) ?: FilterFormat::create(["format" => $id, "name" => "MFL icon format", "weight" => 63]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE, "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <span class data-file-type> <a href> <drupal-media-file-link data-entity-uuid data-entity-type data-file-type>"],
  ]);
  $format->setFilterConfig("media_directories_file_link", [
    "status" => TRUE, "weight" => 90,
    "settings" => ["template" => "<a href=\"@file_url\">@text</a>", "icon" => TRUE],
  ]);
  $format->save();

  $storage = \Drupal::entityTypeManager()->getStorage("media");
  if (!$storage->loadByProperties(["name" => "MFL zip media"])) {
    $fs = \Drupal::service("file_system");
    $dir = "public://mfl-icon";
    $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY);
    $uri = $dir . "/bundle.zip";
    if (!file_exists($uri)) { $fs->saveData("PK" . chr(3) . chr(4) . "mfl", $uri, FileExists::Replace); }
    $file = File::create(["uri" => $uri, "status" => 1]);
    $file->save();
    Media::create([
      "bundle" => "document", "name" => "MFL zip media", "status" => 1,
      "field_media_document" => ["target_id" => $file->id()],
    ])->save();
  }
' >/dev/null 2>&1

echo "setup: mfl_icon_format (icon=TRUE) + document media 'MFL zip media' (bundle.zip)"
