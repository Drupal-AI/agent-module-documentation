#!/usr/bin/env bash
# Introspection CLEANUP: remove the Key entity created by the matching setup. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($k = \Drupal::entityTypeManager()->getStorage("key")->load("ps_known_key")) { $k->delete(); }
' >/dev/null 2>&1
echo "cleanup: key ps_known_key removed"
