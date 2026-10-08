#!/usr/bin/env bash
# Execution CLEANUP: delete the mdc_inline_format format, the MDC inline media item, its file and
# the public://mdc-inline directory. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("mdc_inline_format")) { $f->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MDC inline media"]) as $media) {
    $file = $media->get("field_media_image")->entity;
    $media->delete();
    if ($file) { $file->delete(); }
  }
  \Drupal::service("file_system")->deleteRecursive("public://mdc-inline");
' >/dev/null 2>&1

echo "cleanup: mdc_inline_format and MDC inline media removed"
