#!/usr/bin/env bash
# Introspection SETUP: enable thumbnail download queuing on the remote_audio media type.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("media_type")->load("remote_audio");
  $t->set("queue_thumbnail_downloads", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media.type.remote_audio queue_thumbnail_downloads=TRUE"
