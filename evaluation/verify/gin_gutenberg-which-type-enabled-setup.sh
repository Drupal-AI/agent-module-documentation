#!/usr/bin/env bash
# Introspection SETUP: enable full Gutenberg for the Article type (drives gin_gutenberg). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gutenberg.settings")->set("article_enable_full", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: gutenberg.settings:article_enable_full = TRUE"
