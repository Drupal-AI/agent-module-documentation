#!/usr/bin/env bash
# Introspection SETUP: set a distinctive allowed_extensions list including 'log' so an agent can
# read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("markdownify_file_attachment.settings")
    ->set("allowed_extensions", ["txt","json","log"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: allowed_extensions=[txt,json,log]"
