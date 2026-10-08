#!/usr/bin/env bash
# Execution RESET: set llms_txt.settings.content to the shipped default so verify FAILS until
# the agent sets the required heading. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("llms_txt.settings")
    ->set("content", "# [site:name]\n\n[site:slogan]\n")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: llms_txt.settings.content set to shipped default"
