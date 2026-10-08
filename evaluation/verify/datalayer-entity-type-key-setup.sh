#!/usr/bin/env bash
# MEDIUM setup: rename the dataLayer JSON key for the page entity's type
# (entity_type) away from its default so the agent must read live config.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("datalayer.settings")
    ->set("entity_type", "contentType")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: datalayer.settings entity_type = contentType"
