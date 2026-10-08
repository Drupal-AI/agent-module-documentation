#!/usr/bin/env bash
# Introspection SETUP: create a document media 'mdl_known' with a real file, so the agent can
# inspect the running site and determine that /media/{id} downloads the file (DownloadController)
# rather than rendering the media page. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\file\Entity\File;
  use Drupal\media\Entity\Media;
  $fs = \Drupal::service("file_system");
  $dir = "public://mdl_known"; $fs->prepareDirectory($dir, 1);
  file_put_contents($fs->realpath("public://")."/mdl_known/known.txt", "known media download");
  $existing = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "mdl_known"]);
  if (!$existing) {
    $f = File::create(["uri" => "public://mdl_known/known.txt", "status" => 1]); $f->save();
    Media::create(["bundle" => "document", "name" => "mdl_known", "field_media_document" => ["target_id" => $f->id()]])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: document media 'mdl_known' created (served by DownloadController at /media/{id})"
