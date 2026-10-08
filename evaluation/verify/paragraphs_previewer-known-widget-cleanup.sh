#!/usr/bin/env bash
# Introspection CLEANUP: remove the two Paragraphs fields and the pp_probe paragraph type
# created by the matching setup. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_pp_known", "field_pp_plain"] as $fn) {
    if ($fc = FieldConfig::loadByName("node", "article", $fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node", $fn)) { $fs->delete(); }
  }
  if ($pt = ParagraphsType::load("pp_probe")) { $pt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_pp_known, field_pp_plain and paragraph type pp_probe removed"
