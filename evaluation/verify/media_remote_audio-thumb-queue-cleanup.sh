#!/usr/bin/env bash
# Introspection CLEANUP: restore queue_thumbnail_downloads to shipped default (false).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("media_type")->load("remote_audio");
  $t->set("queue_thumbnail_downloads", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media.type.remote_audio queue_thumbnail_downloads=FALSE"
