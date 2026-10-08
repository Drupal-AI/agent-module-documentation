#!/usr/bin/env bash
# Introspection CLEANUP: remove field_mlmm_probe (and its form-display component). Restores
# baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_mlmm_probe")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_mlmm_probe")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_mlmm_probe removed from node.article"
