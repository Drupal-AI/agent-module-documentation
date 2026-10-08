#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default (add_placeholder=true). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("video_embed_html5.config")->set("add_placeholder", TRUE)->save();' >/dev/null 2>&1
echo "cleanup: video_embed_html5.config add_placeholder=true"
