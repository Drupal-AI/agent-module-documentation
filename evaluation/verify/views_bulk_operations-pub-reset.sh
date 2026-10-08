#!/usr/bin/env bash
# Reset the "publish-only VBO view" execution task to a clean baseline between eval runs:
# delete the `eval_vbo_pub` View config entity (views.view.eval_vbo_pub) if it exists,
# then rebuild caches. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal::entityTypeManager()->getStorage("view")->load("eval_vbo_pub")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view eval_vbo_pub removed"
