#!/usr/bin/env bash
# Introspection CLEANUP: remove both fields + pgc_ptype. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_pgc_classic","field_pgc_modern"] as $fn) {
    if ($fc = FieldConfig::loadByName("node","article",$fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node",$fn)) { $fs->delete(); }
  }
  if ($p = ParagraphsType::load("pgc_ptype")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_pgc_classic/field_pgc_modern + pgc_ptype removed"
