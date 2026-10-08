#!/usr/bin/env bash
# Introspection CLEANUP: remove the nodes, field and vocabulary created by the matching
# setup, restoring the baseline (no trc_topics vocabulary, no field_trc_topic). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["TRC Known One", "TRC Known Two"] as $title) {
    foreach ($storage->loadByProperties(["title" => $title]) as $n) { $n->delete(); }
  }
  if ($fc = FieldConfig::loadByName("node", "article", "field_trc_topic")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_trc_topic")) { $fs->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid" => "trc_topics"]) as $t) { $t->delete(); }
  if ($v = Vocabulary::load("trc_topics")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: trc_topics / field_trc_topic / TRC Known nodes removed"
