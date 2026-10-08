#!/usr/bin/env bash
# Introspection SETUP: enable Flippy for Article with a known Previous-link label. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("flippy.settings")
    ->set("flippy_article", TRUE)
    ->set("flippy_prev_label_article", "Older eval post")
    ->save();
' >/dev/null 2>&1
echo "setup: flippy.settings flippy_article=1, flippy_prev_label_article=\"Older eval post\""
