#!/usr/bin/env bash
# Execution RESET: clear the image_import hard-case baseline. Deletes the
# `mf_eval_image_import` migration config entity if present, then rebuilds caches.
# No arguments. Paths relative to /var/www/html.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($m = \Drupal::entityTypeManager()->getStorage("migration")->load("mf_eval_image_import")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: migration mf_eval_image_import cleared"
