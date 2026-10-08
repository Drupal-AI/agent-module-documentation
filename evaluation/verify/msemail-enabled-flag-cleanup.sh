#!/usr/bin/env bash
# Introspection CLEANUP (message_subscribe_email): disable email_term (baseline: all email_* disabled).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("email_term");
  if ($f->status()) { $f->disable()->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: email_term flag disabled (baseline)"
