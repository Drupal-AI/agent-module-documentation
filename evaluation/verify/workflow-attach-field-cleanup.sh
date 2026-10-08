#!/usr/bin/env bash
# Execution CLEANUP: remove field_wf_attach from node.article and delete the wf_attach workflow.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_wf_attach")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_wf_attach")) { $fs->delete(); }
' >/dev/null 2>&1
drush php:eval '$cf=\Drupal::configFactory(); foreach ($cf->listAll("") as $n) { if (strpos($n,"wf_attach")!==FALSE) $cf->getEditable($n)->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_wf_attach and workflow wf_attach removed"
