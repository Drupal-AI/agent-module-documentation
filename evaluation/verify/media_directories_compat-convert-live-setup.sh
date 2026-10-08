#!/usr/bin/env bash
# Introspection SETUP: create text format mdc_live_format with the legacy-embed filter enabled
# and inline_display_modes EMPTY, plus a real image media item "MDC live media" so the agent
# can run the filter over a legacy <drupal-entity> tag on the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\Core\File\FileSystemInterface;
  use Drupal\file\Entity\File;
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\media\Entity\Media;

  $id = "mdc_live_format";
  $format = FilterFormat::load($id) ?: FilterFormat::create(["format" => $id, "name" => "MDC live format", "weight" => 59]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE, "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <drupal-entity data-entity-type data-entity-uuid data-entity-embed-display data-entity-embed-display-settings data-align> <drupal-media data-entity-type data-entity-uuid data-view-mode data-align data-width data-height>"],
  ]);
  $format->setFilterConfig("media_directories_legacy_embed", [
    "status" => TRUE, "weight" => 0, "settings" => ["inline_display_modes" => []],
  ]);
  $format->setFilterConfig("media_embed", ["status" => TRUE, "weight" => 100, "settings" => []]);
  $format->save();

  $storage = \Drupal::entityTypeManager()->getStorage("media");
  if (!$storage->loadByProperties(["name" => "MDC live media"])) {
    $fs = \Drupal::service("file_system");
    $dir = "public://mdc-live";
    $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY);
    $uri = $dir . "/mdc.png";
    if (!file_exists($uri)) {
      $im = imagecreatetruecolor(24, 24);
      $tmp = $fs->tempnam("temporary://", "mdc");
      imagepng($im, $fs->realpath($tmp));
      $fs->move($tmp, $uri, \Drupal\Core\File\FileExists::Replace);
    }
    $file = File::create(["uri" => $uri, "status" => 1]);
    $file->save();
    Media::create([
      "bundle" => "image", "name" => "MDC live media", "status" => 1,
      "field_media_image" => ["target_id" => $file->id(), "alt" => "MDC live media"],
    ])->save();
  }
' >/dev/null 2>&1

echo "setup: mdc_live_format + image media 'MDC live media' created"
