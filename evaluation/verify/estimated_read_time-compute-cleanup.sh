#!/usr/bin/env bash
# Execution CLEANUP: delete the 'ERT Auto Node' node and remove field_ert_auto. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()->accessCheck(FALSE)->condition("title", "ERT Auto Node")->execute();
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadMultiple($ids) as $n) { $n->delete(); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_ert_auto")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ert_auto")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ERT Auto Node + field_ert_auto removed"
