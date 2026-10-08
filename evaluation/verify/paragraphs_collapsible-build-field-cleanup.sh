#!/usr/bin/env bash
# Execution CLEANUP: remove field_pgc_build + pgc_ptype. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_pgc_build")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_pgc_build")) { $fs->delete(); }
  if ($p = ParagraphsType::load("pgc_ptype")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_pgc_build + pgc_ptype removed"
