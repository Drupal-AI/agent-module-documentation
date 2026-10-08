#!/usr/bin/env bash
# medium CLEANUP (altcha_obfuscate): remove field_aobf_email. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_aobf_email")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_aobf_email")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_aobf_email removed"
