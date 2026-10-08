#!/usr/bin/env bash
# hard CLEANUP (altcha_obfuscate): remove field_aobf_mail. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_aobf_mail")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_aobf_mail")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_aobf_mail removed"
