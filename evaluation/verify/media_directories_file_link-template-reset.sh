#!/usr/bin/env bash
# Execution RESET for "customise the file-link template".
# Rebuilds mfl_tpl_format with the file-link filter enabled but at its DEFAULT settings
# (template <a href="@file_url">@text</a>, icon TRUE), and ensures the document media item
# "MFL template media" exists. Verify FAILS until the template and icon setting are changed.
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

  $id = "mfl_tpl_format";
  if ($e = Editor::load($id)) { $e->delete(); }
  if ($f = FilterFormat::load($id)) { $f->delete(); }

  $format = FilterFormat::create(["format" => $id, "name" => "MFL template format", "weight" => 65]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE, "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <strong> <span class data-file-type> <a href> <drupal-media-file-link data-entity-uuid data-entity-type data-file-type>"],
  ]);
  $format->setFilterConfig("media_directories_file_link", [
    "status" => TRUE, "weight" => 90,
    "settings" => ["template" => "<a href=\"@file_url\">@text</a>", "icon" => TRUE],
  ]);
  $format->save();

  $editor = Editor::create(["format" => $id, "editor" => "ckeditor5"]);
  $editor->setSettings(["toolbar" => ["items" => ["bold", "mediaFileLinkButton"]], "plugins" => []]);
  $editor->setImageUploadSettings(["status" => FALSE]);
  $editor->save();

  $storage = \Drupal::entityTypeManager()->getStorage("media");
  if (!$storage->loadByProperties(["name" => "MFL template media"])) {
    $fs = \Drupal::service("file_system");
    $dir = "public://mfl-tpl";
    $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY);
    $uri = $dir . "/datasheet.txt";
    if (!file_exists($uri)) { $fs->saveData("MFL datasheet body", $uri, FileExists::Replace); }
    $file = File::create(["uri" => $uri, "status" => 1]);
    $file->save();
    Media::create([
      "bundle" => "document", "name" => "MFL template media", "status" => 1,
      "field_media_document" => ["target_id" => $file->id()],
    ])->save();
  }
' >/dev/null 2>&1

echo "reset: mfl_tpl_format file-link filter at DEFAULT template/icon; media 'MFL template media' present"
