#!/usr/bin/env bash
# Introspection CLEANUP (bp_contact): remove the bpcontact_probe bundle and its two reference
# fields. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\paragraphs\Entity\ParagraphsType;
  foreach (["field_bpcontact_ref", "field_bpcontact_node"] as $name) {
    if ($fc = FieldConfig::loadByName("paragraph", "bpcontact_probe", $name)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("paragraph", $name)) { $fs->delete(); }
  }
  if ($t = ParagraphsType::load("bpcontact_probe")) { $t->delete(); }
' >/dev/null 2>&1
drush php:eval 'field_purge_batch(200);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: bpcontact_probe bundle and its reference fields removed"
