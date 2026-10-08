#!/usr/bin/env bash
# Execution CLEANUP: remove field_ft_led. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_ft_led")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_ft_led")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ft_led removed"
