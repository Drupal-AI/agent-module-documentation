#!/usr/bin/env bash
# Execution RESET: ensure the imagick_task image style does NOT exist, so verify FAILS until
# the agent builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($s = \Drupal::entityTypeManager()->getStorage("image_style")->load("imagick_task")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: image style imagick_task absent"
