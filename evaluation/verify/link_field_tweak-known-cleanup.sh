#!/usr/bin/env bash
# Introspection CLEANUP: remove field_lft_known from Article (drops its form-display component
# and third-party settings). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_lft_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_lft_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_lft_known removed"
