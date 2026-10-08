#!/usr/bin/env bash
# Optional CLEANUP for hard cases: remove the hard fixture entirely. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_pt_evh")){$fc->delete();}
  if ($fs=FieldStorageConfig::loadByName("node","field_pt_evh")){$fs->delete();}
  if ($pt=ParagraphsType::load("pt_evh")){$pt->delete();}
' >/dev/null 2>&1
echo "cleanup: removed hard fixture (field_pt_evh, pt_evh)"
