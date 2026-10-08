#!/usr/bin/env bash
# Introspection CLEANUP: remove the field_wf_known field and the wf_field workflow. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_wf_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_wf_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush php:eval '$cf=\Drupal::configFactory(); foreach ($cf->listAll("") as $n) { if (strpos($n,"wf_field")!==FALSE) $cf->getEditable($n)->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_wf_known and workflow wf_field removed"
