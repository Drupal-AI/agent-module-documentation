#!/usr/bin/env bash
# Execution RESET: remove any prior mtpdf_eval media/thumbnail/file, then stage a real one-page
# PDF at public://mtpdf_eval/source.pdf with a managed File entity (mime application/pdf), so the
# agent can create a 'document' media entity referencing it. No media entity is created here, so
# verify FAILS until the agent creates the media (which triggers the PDF thumbnail plugin).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\file\Entity\File;
  use Drupal\media\Entity\Media;
  use Drupal\Core\File\FileSystemInterface;
  $etm = \Drupal::entityTypeManager();
  // Remove any prior media named mtpdf_eval and its generated thumbnail.
  foreach ($etm->getStorage("media")->loadByProperties(["name" => "mtpdf_eval"]) as $m) {
    $tid = $m->get("thumbnail")->target_id;
    $m->delete();
    if ($tid && ($t = File::load($tid))) {
      $uri = $t->getFileUri();
      if (strpos($uri, "public://mtpdf_eval/") === 0) { $t->delete(); }
    }
  }
  // Remove the staged source file entity + generated jpg if present.
  foreach ($etm->getStorage("file")->loadByProperties(["uri" => "public://mtpdf_eval/source.pdf"]) as $f) { $f->delete(); }
  foreach ($etm->getStorage("file")->loadByProperties(["uri" => "public://mtpdf_eval/source.pdf.jpg"]) as $f) { $f->delete(); }
  // Stage a fresh single-page PDF and a managed File entity for it.
  $fs = \Drupal::service("file_system");
  $dir = "public://mtpdf_eval";
  $fs->prepareDirectory($dir, FileSystemInterface::CREATE_DIRECTORY);
  $im = new Imagick();
  $im->newImage(120, 160, "white");
  $im->setImageFormat("pdf");
  $im->writeImage($fs->realpath($dir) . "/source.pdf");
  $im->clear();
  $file = File::create(["uri" => "public://mtpdf_eval/source.pdf", "filemime" => "application/pdf", "status" => 1]);
  $file->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: staged public://mtpdf_eval/source.pdf (managed File, application/pdf); no media yet"
