#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","cfeb_eval","field_cfeb_ref")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_cfeb_ref")) { $fs->delete(); }
  $m=\Drupal::service("entity_field.manager")->getFieldMap()["node"]??[];
  $left=array_filter(array_keys($m),fn($x)=>str_starts_with($x,"field_cfeb_"));
  if(!$left && ($t=NodeType::load("cfeb_eval"))){$t->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_cfeb_ref removed"
