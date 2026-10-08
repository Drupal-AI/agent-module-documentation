#!/usr/bin/env bash
# Execution CLEANUP: remove field_cf_task (and cf_eval if no custom fields remain). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","cf_eval","field_cf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_cf_task")) { $fs->delete(); }
  $left = array_filter(array_keys(\Drupal::service("entity_field.manager")->getFieldDefinitions("node","cf_eval")), fn($n)=>str_starts_with($n,"field_cf_"));
  if (!$left && ($t = NodeType::load("cf_eval"))) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_cf_task removed"
