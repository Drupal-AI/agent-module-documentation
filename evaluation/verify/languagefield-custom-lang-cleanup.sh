#!/usr/bin/env bash
# Introspection CLEANUP: remove the custom_language.lf_klingon config entity created by setup.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("custom_language");
  if ($e = $s->load("lf_klingon")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: custom_language.lf_klingon removed"
