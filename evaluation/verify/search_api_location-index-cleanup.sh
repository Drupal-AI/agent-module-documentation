#!/usr/bin/env bash
# Introspection CLEANUP: delete the sal_test_index index and the field_sal_geo geofield.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\search_api\Entity\Index;
  if ($i = Index::load("sal_test_index")) { $i->delete(); }
  if ($fc = FieldConfig::loadByName("node","article","field_sal_geo")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_sal_geo")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sal_test_index and field_sal_geo removed"
