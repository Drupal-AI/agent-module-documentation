#!/usr/bin/env bash
# Introspection SETUP: make the Article content type default to displaying the updated date by
# setting the display_updated base-field-override default to TRUE. Agent inspects whether new
# Articles default to showing the updated date. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $defs = \Drupal::service("entity_field.manager")->getFieldDefinitions("node","article");
  $defs["display_updated"]->getConfig("article")->setDefaultValue(TRUE)->save();
  \Drupal::service("entity_field.manager")->clearCachedFieldDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article display_updated default = TRUE"
