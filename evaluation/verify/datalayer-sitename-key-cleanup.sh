#!/usr/bin/env bash
# MEDIUM cleanup: restore site_name to its install default (siteName).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("datalayer.settings")
    ->set("site_name", "siteName")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: datalayer.settings site_name restored to siteName"
