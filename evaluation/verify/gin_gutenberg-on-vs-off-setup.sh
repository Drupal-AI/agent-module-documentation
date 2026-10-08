#!/usr/bin/env bash
# Introspection SETUP: page_enable_full TRUE, article_enable_full FALSE. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gutenberg.settings")
    ->set("page_enable_full", TRUE)
    ->set("article_enable_full", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: page_enable_full=TRUE, article_enable_full=FALSE"
