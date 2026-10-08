#!/usr/bin/env bash
# Execution RESET for "enable legacy embed compatibility on a text format".
# Rebuilds mdc_task_format with filter_html + media_embed but NO media_directories_legacy_embed
# filter, and ensures the image media item "MDC task media" exists so verify can prove the
# conversion really happens. Verify FAILS on this state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\Core\File\FileSystemInterface;
  use Drupal\file\Entity\File;
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\media\Entity\Media;

  $id = "mdc_task_format";
  if ($f = FilterFormat::load($id)) { $f->delete(); }
  $format = FilterFormat::create(["format" => $id, "name" => "MDC task format", "weight" => 60]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE, "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <a href data-entity-type data-entity-uuid> <drupal-entity data-entity-type data-entity-uuid data-entity-embed-display data-entity-embed-display-settings data-align> <drupal-media data-entity-type data-entity-uuid data-view-mode data-align data-width data-height>"],
  ]);
  $format->setFilterConfig("media_embed", ["status" => TRUE, "weight" => 100, "settings" => []]);
  $format->save();

  $storage = \Drupal::entityTypeManager()->getStorage("media");
  if (!$storage->loadByProperties(["name" => "MDC task media"])) {
    $fs = \Drupal::service("file_system");
    $dir = "public://mdc-task";
    $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY);
    $uri = $dir . "/mdc-task.png";
    if (!file_exists($uri)) {
      $im = imagecreatetruecolor(24, 24);
      $tmp = $fs->tempnam("temporary://", "mdctask");
      imagepng($im, $fs->realpath($tmp));
      $fs->move($tmp, $uri, \Drupal\Core\File\FileExists::Replace);
    }
    $file = File::create(["uri" => $uri, "status" => 1]);
    $file->save();
    Media::create([
      "bundle" => "image", "name" => "MDC task media", "status" => 1,
      "field_media_image" => ["target_id" => $file->id(), "alt" => "MDC task media"],
    ])->save();
  }
' >/dev/null 2>&1

echo "reset: mdc_task_format has no legacy embed filter; media 'MDC task media' present"
