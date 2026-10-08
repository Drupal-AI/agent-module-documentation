#!/usr/bin/env bash
# Execution CLEANUP: remove the isg_gen style, the source image, its file entity and any
# derivative created during the warm case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $fs = \Drupal::service("file_system");
  if ($style = ImageStyle::load("isg_gen")) {
    $deriv = $style->buildUri("public://isg_warm_src.png");
    if (file_exists($deriv)) { $fs->delete($deriv); }
    $style->delete();
  }
  foreach (\Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => "public://isg_warm_src.png"]) as $f) { $f->delete(); }
  $base = $fs->realpath("public://");
  if ($base && file_exists($base . "/isg_warm_src.png")) { $fs->delete("public://isg_warm_src.png"); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: isg_gen style + isg_warm_src.png + derivative removed"
