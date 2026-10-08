#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped Slideshow block type label.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("block_content_type")->load("media_slideshow");
  $t->set("label", "Slideshow")->save();
' >/dev/null 2>&1
echo "cleanup: block_content type media_slideshow label restored to 'Slideshow'"
