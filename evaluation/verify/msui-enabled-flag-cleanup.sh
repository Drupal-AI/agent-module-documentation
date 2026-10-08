#!/usr/bin/env bash
# Introspection CLEANUP (message_subscribe_ui): disable subscribe_user (baseline: all subscribe_* disabled).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("subscribe_user");
  if ($f->status()) { $f->disable()->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: subscribe_user flag disabled (baseline)"
