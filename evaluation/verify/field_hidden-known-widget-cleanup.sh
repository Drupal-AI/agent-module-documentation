#!/usr/bin/env bash
# Introspection CLEANUP: remove field_fh_secret (also drops its form-display component).
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fh_secret")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fh_secret")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_fh_secret removed from node.article"
