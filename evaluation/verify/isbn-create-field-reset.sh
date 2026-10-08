#!/usr/bin/env bash
# Execution RESET: ensure field_isbn_build does NOT exist on Article, so verify FAILs until
# the agent creates the ISBN field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_isbn_build")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_isbn_build")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_isbn_build absent"
