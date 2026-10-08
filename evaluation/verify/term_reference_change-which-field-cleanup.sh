#!/usr/bin/env bash
# Introspection CLEANUP: drop both fields and the trc_subjects vocabulary added by the
# matching setup. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_trc_primary", "field_trc_related"] as $name) {
    if ($fc = FieldConfig::loadByName("node", "article", $name)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node", $name)) { $fs->delete(); }
  }
  foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid" => "trc_subjects"]) as $t) { $t->delete(); }
  if ($v = Vocabulary::load("trc_subjects")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_trc_primary / field_trc_related / trc_subjects removed"
