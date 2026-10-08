#!/usr/bin/env bash
# Introspection CLEANUP: delete the rsw_eval_style image style created by the matching setup.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("rsw_eval_style")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: image style rsw_eval_style removed"
