#!/usr/bin/env bash
# Execution RESET for "default view modes for embedded media".
# Rebuilds the throwaway text format mdb_task_format with filter_html + media_embed only —
# no media_directories_default_view_mode filter — so verify FAILS on empty state. Also ensures
# one image media item exists so verify can assert the filter really rewrites markup.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\editor\Entity\Editor;
  use Drupal\filter\Entity\FilterFormat;

  $id = "mdb_task_format";
  if ($e = Editor::load($id)) { $e->delete(); }
  if ($f = FilterFormat::load($id)) { $f->delete(); }

  $format = FilterFormat::create([
    "format" => $id,
    "name" => "MDB task format",
    "weight" => 53,
  ]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE,
    "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <drupal-media data-entity-type data-entity-uuid data-view-mode>"],
  ]);
  $format->setFilterConfig("media_embed", ["status" => TRUE, "weight" => 100, "settings" => []]);
  $format->save();

  $editor = Editor::create(["format" => $id, "editor" => "ckeditor5"]);
  $editor->setSettings(["toolbar" => ["items" => ["bold", "drupalMedia"]], "plugins" => []]);
  $editor->setImageUploadSettings(["status" => FALSE]);
  $editor->save();

  // A real image media item so verify can prove the filter actually rewrites markup.
  $media_storage = \Drupal::entityTypeManager()->getStorage("media");
  if (!$media_storage->loadByProperties(["name" => "MDB task image"])) {
    $fs = \Drupal::service("file_system");
    $dir = "public://mdb-task";
    $fs->prepareDirectory($dir, \Drupal\Core\File\FileSystemInterface::CREATE_DIRECTORY);
    $uri = $dir . "/mdb-task-image.png";
    if (!file_exists($uri)) {
      $im = imagecreatetruecolor(16, 16);
      $tmp = $fs->tempnam("temporary://", "mdbtask");
      imagepng($im, $fs->realpath($tmp));
      $fs->move($tmp, $uri, \Drupal\Core\File\FileExists::Replace);
    }
    $file = \Drupal\file\Entity\File::create(["uri" => $uri, "status" => 1]);
    $file->save();
    \Drupal\media\Entity\Media::create([
      "bundle" => "image",
      "name" => "MDB task image",
      "field_media_image" => ["target_id" => $file->id(), "alt" => "MDB task image"],
      "status" => 1,
    ])->save();
  }
' >/dev/null 2>&1

echo "reset: mdb_task_format rebuilt without media_directories_default_view_mode; image media 'MDB task image' present"
