#!/usr/bin/env bash
# Execution CLEANUP for the migrate case: remove field_mlmm_mig (whichever type it now is),
# dropping its data column. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_mlmm_mig")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_mlmm_mig")) { $fs->delete(); }
  drupal_flush_all_caches();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_mlmm_mig removed from node.article"
