#!/usr/bin/env bash
# Introspection CLEANUP: remove field_fwam_known (drops its form-display component + setting).
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fwam_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fwam_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_fwam_known removed from node.article"
