#!/usr/bin/env bash
# Introspection CLEANUP: remove field_cfmedia_wid (+ cfmedia_eval if no custom fields left). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","cfmedia_eval","field_cfmedia_wid")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_cfmedia_wid")) { $fs->delete(); }
  $left = array_filter(array_keys(\Drupal::service("entity_field.manager")->getFieldDefinitions("node","cfmedia_eval")), fn($n)=>str_starts_with($n,"field_cfmedia_"));
  if (!$left && ($t = NodeType::load("cfmedia_eval"))) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_cfmedia_wid removed"
