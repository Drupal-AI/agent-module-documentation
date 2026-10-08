#!/usr/bin/env bash
# Introspection CLEANUP: restore Kint settings to shipped defaults (original.css, no early enable). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("kint.settings")
    ->set("rich_theme", "original.css")
    ->set("early_enable", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: kint.settings restored (rich_theme=original.css, early_enable=FALSE)"
