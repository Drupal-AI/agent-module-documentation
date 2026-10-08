#!/usr/bin/env bash
# Execution RESET: delete the rsw_task_thumb image style and any managed file named
# rsw_task_thumb_source.png, so the site has neither and the verify fails on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("rsw_task_thumb")) { $s->delete(); }
  $storage = \Drupal::entityTypeManager()->getStorage("file");
  foreach ($storage->loadByProperties(["filename" => "rsw_task_thumb_source.png"]) as $f) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: image style rsw_task_thumb and file rsw_task_thumb_source.png removed"
