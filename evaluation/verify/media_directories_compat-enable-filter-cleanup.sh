#!/usr/bin/env bash
# Execution CLEANUP: delete the mdc_task_format format, the MDC task media item, its file and
# the public://mdc-task directory. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("mdc_task_format")) { $f->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MDC task media"]) as $media) {
    $file = $media->get("field_media_image")->entity;
    $media->delete();
    if ($file) { $file->delete(); }
  }
  \Drupal::service("file_system")->deleteRecursive("public://mdc-task");
' >/dev/null 2>&1

echo "cleanup: mdc_task_format and MDC task media removed"
