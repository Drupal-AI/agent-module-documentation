#!/usr/bin/env bash
# HARD execution RESET: remove field_eh_task so the site has NO such field. verify then FAILs
# until the agent adds an entity_reference_hierarchy field field_eh_task to Article. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_eh_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_eh_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_eh_task absent on node.article"
