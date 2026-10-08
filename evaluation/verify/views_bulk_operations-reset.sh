#!/usr/bin/env bash
# Reset the VBO build task to a clean, known baseline between eval runs so each
# condition is independent: delete the `eval_vbo` view config entity
# (views.view.eval_vbo) if it exists, then rebuild caches.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("eval_vbo");
  if ($v) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view eval_vbo removed"
