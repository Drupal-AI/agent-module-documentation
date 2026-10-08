#!/usr/bin/env bash
# Introspection CLEANUP (message_subscribe_ui): restore subscribe_term's shipped/email baseline View.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("subscribe_term");
  $f->setThirdPartySetting("message_subscribe_ui", "view_name", "subscribe_taxonomy_term_email:default")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: subscribe_term view_name restored to subscribe_taxonomy_term_email:default"
