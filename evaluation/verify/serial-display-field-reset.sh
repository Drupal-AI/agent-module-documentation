#!/usr/bin/env bash
# Execution RESET (serial H2): remove field_srl_evt from Article (also drops its display
# component) so the agent must create it AND show it with the Serial default formatter.
# Empty state => verify FAILS. Only touches this module's own field_srl_* storage. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_srl_evt")){$fc->delete();}
  if ($fs=FieldStorageConfig::loadByName("node","field_srl_evt")){$fs->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_srl_evt removed from node.article"
