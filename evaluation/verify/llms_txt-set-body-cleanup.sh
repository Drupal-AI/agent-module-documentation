#!/usr/bin/env bash
# Execution CLEANUP: restore llms_txt.settings.content to the shipped default. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("llms_txt.settings")
    ->set("content", "# [site:name]\n\n[site:slogan]\n")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: llms_txt.settings.content restored to shipped default"
