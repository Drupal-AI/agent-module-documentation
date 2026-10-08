#!/usr/bin/env bash
# Introspection SETUP: set remove_beginning_words to defaults + custom 'Xanadu'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("views_natural_sort.settings")
    ->set("transformation_settings.remove_beginning_words.settings", ["The","A","An","La","Le","Il","Xanadu"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: beginning words include Xanadu"
