#!/usr/bin/env bash
# Execution RESET for "add the Insert file link button to a text format".
# Rebuilds mfl_task_format as a CKEditor 5 format WITHOUT the media_directories_file_link
# filter and without the mediaFileLinkButton toolbar item, and ensures a document media item
# "MFL task media" backed by a real PDF-ish file exists. Verify FAILS on this state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\Core\File\FileExists;
  use Drupal\Core\File\FileSystemInterface;
  use Drupal\editor\Entity\Editor;
  use Drupal\file\Entity\File;
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\media\Entity\Media;

  $id = "mfl_task_format";
  if ($e = Editor::load($id)) { $e->delete(); }
  if ($f = FilterFormat::load($id)) { $f->delete(); }

  $format = FilterFormat::create(["format" => $id, "name" => "MFL task format", "weight" => 64]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE, "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <strong> <span class data-file-type> <a href> <drupal-media-file-link data-entity-uuid data-entity-type data-file-type>"],
  ]);
  $format->save();

  $editor = Editor::create(["format" => $id, "editor" => "ckeditor5"]);
  $editor->setSettings(["toolbar" => ["items" => ["bold"]], "plugins" => []]);
  $editor->setImageUploadSettings(["status" => FALSE]);
  $editor->save();

  $storage = \Drupal::entityTypeManager()->getStorage("media");
  if (!$storage->loadByProperties(["name" => "MFL task media"])) {
    $fs = \Drupal::service("file_system");
    $dir = "public://mfl-task";
    $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY);
    $uri = $dir . "/handbook.txt";
    if (!file_exists($uri)) { $fs->saveData("MFL task handbook", $uri, FileExists::Replace); }
    $file = File::create(["uri" => $uri, "status" => 1]);
    $file->save();
    Media::create([
      "bundle" => "document", "name" => "MFL task media", "status" => 1,
      "field_media_document" => ["target_id" => $file->id()],
    ])->save();
  }
' >/dev/null 2>&1

echo "reset: mfl_task_format has no file-link filter or toolbar button; media 'MFL task media' present"
