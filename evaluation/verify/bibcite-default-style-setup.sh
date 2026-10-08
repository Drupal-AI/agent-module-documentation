#!/usr/bin/env bash
# Introspection SETUP: set the site-wide default citation style to Chicago author-date, so an
# agent can read bibcite.settings and report the configured default style. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bibcite.settings")
    ->set("processor", "citeproc-php")->set("default_style", "chicago_author_date")->set("convert_urls", FALSE)->save();
' >/dev/null 2>&1
echo "setup: bibcite.settings default_style=chicago_author_date"
