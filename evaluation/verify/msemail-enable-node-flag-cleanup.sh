#!/usr/bin/env bash
# Execution CLEANUP (message_subscribe_email): disable email_node (baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("email_node");
  if ($f->status()) { $f->disable()->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: email_node flag disabled (baseline)"
