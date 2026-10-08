#!/usr/bin/env bash
# Restore shipped default disclaimer title. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("google_translator.settings")
    ->set("google_translator_disclaimer_title", "Automatic translation disclaimer")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: google_translator disclaimer_title restored"
