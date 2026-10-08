#!/usr/bin/env bash
# Execution CLEANUP: delete the mtpdf_eval media, its thumbnail, the source File, and the staged
# directory. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\file\Entity\File;
  $etm = \Drupal::entityTypeManager();
  foreach ($etm->getStorage("media")->loadByProperties(["name" => "mtpdf_eval"]) as $m) {
    $tid = $m->get("thumbnail")->target_id;
    $m->delete();
    if ($tid && ($t = File::load($tid))) {
      $uri = $t->getFileUri();
      if (strpos($uri, "public://mtpdf_eval/") === 0) { $t->delete(); }
    }
  }
  foreach ($etm->getStorage("file")->loadByProperties(["uri" => "public://mtpdf_eval/source.pdf"]) as $f) { $f->delete(); }
  foreach ($etm->getStorage("file")->loadByProperties(["uri" => "public://mtpdf_eval/source.pdf.jpg"]) as $f) { $f->delete(); }
  \Drupal::service("file_system")->deleteRecursive("public://mtpdf_eval");
' >/dev/null 2>&1
echo "cleanup: mtpdf_eval media/files/dir removed"
