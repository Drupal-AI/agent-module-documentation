#!/usr/bin/env bash
# Introspection CLEANUP: remove the medium fixture (field + paragraph type). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_pt_evm")){$fc->delete();}
  if ($fs=FieldStorageConfig::loadByName("node","field_pt_evm")){$fs->delete();}
  if ($pt=ParagraphsType::load("pt_evm")){$pt->delete();}
' >/dev/null 2>&1
echo "cleanup: removed medium fixture (field_pt_evm, pt_evm)"
