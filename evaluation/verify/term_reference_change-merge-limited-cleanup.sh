#!/usr/bin/env bash
# Execution CLEANUP: remove the nodes, field and vocabulary built for the limited-merge case.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["TRC Limit Keep 1", "TRC Limit Keep 2", "TRC Limit Move"] as $title) {
    foreach ($storage->loadByProperties(["title" => $title]) as $n) { $n->delete(); }
  }
  if ($fc = FieldConfig::loadByName("node", "article", "field_trc_limit")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_trc_limit")) { $fs->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid" => "trc_limit"]) as $t) { $t->delete(); }
  if ($v = Vocabulary::load("trc_limit")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: trc_limit vocabulary, field_trc_limit and TRC Limit nodes removed"
