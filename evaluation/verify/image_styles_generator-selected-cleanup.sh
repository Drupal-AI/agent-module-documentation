#!/usr/bin/env bash
# Execution CLEANUP: remove isg_sela + isg_selb styles, the source image, its file entity and
# any derivatives created during the selected-warm case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $fs = \Drupal::service("file_system");
  foreach (["isg_sela", "isg_selb"] as $name) {
    if ($style = ImageStyle::load($name)) {
      $deriv = $style->buildUri("public://isg_sel_src.png");
      if (file_exists($deriv)) { $fs->delete($deriv); }
      $style->delete();
    }
  }
  foreach (\Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => "public://isg_sel_src.png"]) as $f) { $f->delete(); }
  $base = $fs->realpath("public://");
  if ($base && file_exists($base . "/isg_sel_src.png")) { $fs->delete("public://isg_sel_src.png"); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: isg_sela + isg_selb + isg_sel_src.png + derivatives removed"
