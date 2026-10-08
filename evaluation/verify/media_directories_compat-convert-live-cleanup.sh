#!/usr/bin/env bash
# Introspection CLEANUP: delete the mdc_live_format format, the "MDC live media" item, its
# file and the public://mdc-live directory. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("mdc_live_format")) { $f->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MDC live media"]) as $media) {
    $file = $media->get("field_media_image")->entity;
    $media->delete();
    if ($file) { $file->delete(); }
  }
  \Drupal::service("file_system")->deleteRecursive("public://mdc-live");
' >/dev/null 2>&1

echo "cleanup: mdc_live_format and MDC live media removed"
