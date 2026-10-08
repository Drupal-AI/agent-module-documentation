#!/usr/bin/env bash
# Introspection CLEANUP: restore Article's display_updated default to FALSE (shipped default).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $defs = \Drupal::service("entity_field.manager")->getFieldDefinitions("node","article");
  $defs["display_updated"]->getConfig("article")->setDefaultValue(FALSE)->save();
  \Drupal::service("entity_field.manager")->clearCachedFieldDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article display_updated default reset to FALSE"
