#!/usr/bin/env bash
# Execution RESET for "render legacy document embeds as download links".
# Rebuilds mdc_inline_format with filter_html + media_embed but NO media_directories_legacy_embed
# filter, and ensures an image media item "MDC inline media" exists to embed. Verify FAILS on
# this state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\Core\File\FileSystemInterface;
  use Drupal\file\Entity\File;
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\media\Entity\Media;

  $id = "mdc_inline_format";
  if ($f = FilterFormat::load($id)) { $f->delete(); }
  $format = FilterFormat::create(["format" => $id, "name" => "MDC inline format", "weight" => 61]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE, "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <a href data-entity-type data-entity-uuid> <drupal-entity data-entity-type data-entity-uuid data-entity-embed-display data-entity-embed-display-settings data-align> <drupal-media data-entity-type data-entity-uuid data-view-mode data-align data-width data-height>"],
  ]);
  $format->setFilterConfig("media_embed", ["status" => TRUE, "weight" => 100, "settings" => []]);
  $format->save();

  $storage = \Drupal::entityTypeManager()->getStorage("media");
  if (!$storage->loadByProperties(["name" => "MDC inline media"])) {
    $fs = \Drupal::service("file_system");
    $dir = "public://mdc-inline";
    $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY);
    $uri = $dir . "/mdc-inline.png";
    if (!file_exists($uri)) {
      $im = imagecreatetruecolor(24, 24);
      $tmp = $fs->tempnam("temporary://", "mdcinline");
      imagepng($im, $fs->realpath($tmp));
      $fs->move($tmp, $uri, \Drupal\Core\File\FileExists::Replace);
    }
    $file = File::create(["uri" => $uri, "status" => 1]);
    $file->save();
    Media::create([
      "bundle" => "image", "name" => "MDC inline media", "status" => 1,
      "field_media_image" => ["target_id" => $file->id(), "alt" => "MDC inline media"],
    ])->save();
  }
' >/dev/null 2>&1

echo "reset: mdc_inline_format has no legacy embed filter; media 'MDC inline media' present"
