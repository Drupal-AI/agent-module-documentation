#!/usr/bin/env bash
# Execution CLEANUP (serial H1): remove field_srl_task from Article so the agent must create it.
# Empty state => verify FAILS. Only removes this module's own field_srl_* storage. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_srl_task")){$fc->delete();}
  if ($fs=FieldStorageConfig::loadByName("node","field_srl_task")){$fs->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_srl_task removed from node.article"
