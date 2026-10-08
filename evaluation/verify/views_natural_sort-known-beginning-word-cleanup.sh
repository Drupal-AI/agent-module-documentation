#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default beginning words. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("views_natural_sort.settings")
    ->set("transformation_settings.remove_beginning_words.settings", ["The","A","An","La","Le","Il"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: beginning words restored to default"
