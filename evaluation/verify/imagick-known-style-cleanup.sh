#!/usr/bin/env bash
# Introspection CLEANUP: delete the imagick_known image style created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($s = \Drupal::entityTypeManager()->getStorage("image_style")->load("imagick_known")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: image style imagick_known removed"
