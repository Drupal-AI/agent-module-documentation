#!/usr/bin/env bash
# Execution CLEANUP: remove the nodes, field and vocabulary built for the merge-all case.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["TRC Merge A", "TRC Merge B", "TRC Merge C"] as $title) {
    foreach ($storage->loadByProperties(["title" => $title]) as $n) { $n->delete(); }
  }
  if ($fc = FieldConfig::loadByName("node", "article", "field_trc_merge")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_trc_merge")) { $fs->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid" => "trc_merge"]) as $t) { $t->delete(); }
  if ($v = Vocabulary::load("trc_merge")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: trc_merge vocabulary, field_trc_merge and TRC Merge nodes removed"
