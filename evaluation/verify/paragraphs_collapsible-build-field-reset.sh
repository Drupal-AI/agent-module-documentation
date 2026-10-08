#!/usr/bin/env bash
# Execution RESET: ensure NO paragraphs field field_pgc_build exists on Article (but a paragraph
# type pgc_ptype is available), so verify FAILS until the agent creates a paragraphs field that
# uses the classic entity_reference_paragraphs widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!ParagraphsType::load("pgc_ptype")) { ParagraphsType::create(["id"=>"pgc_ptype","label"=>"PGC Paragraph"])->save(); }
  if ($fc = FieldConfig::loadByName("node","article","field_pgc_build")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_pgc_build")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_pgc_build absent, pgc_ptype available"
