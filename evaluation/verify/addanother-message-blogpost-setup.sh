#!/usr/bin/env bash
# Introspection SETUP: configure the after-save message OFF for blog_post. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("addanother.settings");
  $c->set("default_message", TRUE)->set("message.blog_post", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: addanother.settings message.blog_post=false"
