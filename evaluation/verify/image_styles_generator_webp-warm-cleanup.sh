#!/usr/bin/env bash
# Execution CLEANUP for the WebP warm case: remove the isg_webp style, source image, file
# entity, derivative and .webp copy. Leaves the submodule enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $fs = \Drupal::service("file_system");
  if ($style = ImageStyle::load("isg_webp")) {
    $deriv = $style->buildUri("public://isg_wsrc.png");
    $webp = preg_replace("/\\.png$/", ".webp", $deriv);
    if (file_exists($deriv)) { $fs->delete($deriv); }
    if (file_exists($webp)) { $fs->delete($webp); }
    $style->delete();
  }
  foreach (\Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => "public://isg_wsrc.png"]) as $f) { $f->delete(); }
  $base = $fs->realpath("public://");
  if ($base && file_exists($base . "/isg_wsrc.png")) { $fs->delete("public://isg_wsrc.png"); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: isg_webp style + isg_wsrc.png + derivative + .webp removed"
