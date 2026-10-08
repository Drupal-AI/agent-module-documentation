#!/usr/bin/env bash
# Execution RESET: force article_enable_full FALSE so verify FAILS until enabled. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gutenberg.settings")->set("article_enable_full", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: gutenberg.settings:article_enable_full = FALSE"
