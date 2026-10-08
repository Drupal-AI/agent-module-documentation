#!/usr/bin/env bash
# Execution RESET: Flippy on for Article but head links OFF, so verify FAILS until enabled.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("flippy.settings")
    ->set("flippy_article", TRUE)->set("flippy_head_article", FALSE)->save();
' >/dev/null 2>&1
echo "reset: flippy_article=TRUE, flippy_head_article=FALSE"
