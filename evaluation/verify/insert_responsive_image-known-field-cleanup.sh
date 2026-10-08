#!/usr/bin/env bash
# Introspection CLEANUP (insert_responsive_image): remove field_insert_ri and the namespaced
# Responsive Image style insert_ri_demo. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\responsive_image\Entity\ResponsiveImageStyle;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_insert_ri")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_insert_ri")) { $fs->delete(); }
  if ($r = ResponsiveImageStyle::load("insert_ri_demo")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_insert_ri and responsive style insert_ri_demo removed"
