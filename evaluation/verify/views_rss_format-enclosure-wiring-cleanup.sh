#!/usr/bin/env bash
# Introspection CLEANUP: remove the vrss_fmt_enclosure View. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $storage->load("vrss_fmt_enclosure")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vrss_fmt_enclosure removed"
