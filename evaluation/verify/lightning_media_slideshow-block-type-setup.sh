#!/usr/bin/env bash
# Introspection SETUP: relabel the Slideshow custom block type so the agent must find it by
# label on the live site and report its machine name and the media reference field on it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("block_content_type")->load("media_slideshow");
  $t->set("label", "LM Carousel")->save();
' >/dev/null 2>&1
echo "setup: block_content type media_slideshow relabelled 'LM Carousel'"
