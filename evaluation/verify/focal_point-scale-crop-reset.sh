#!/usr/bin/env bash
# Reset the Focal Point execution evals to a clean baseline between runs so each
# condition is independent: delete the throwaway eval image styles this suite builds
# (eval_focal_crop, eval_focal_wide) if they exist, then rebuild caches.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("image_style");
  foreach (["eval_focal_crop", "eval_focal_wide"] as $id) {
    if ($s = $storage->load($id)) { $s->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: eval image styles (eval_focal_crop, eval_focal_wide) removed"
