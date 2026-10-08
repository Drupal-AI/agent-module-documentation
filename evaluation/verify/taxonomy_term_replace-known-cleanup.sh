#!/usr/bin/env bash
# Introspection CLEANUP: delete the probe nodes, field_ttr_kref, and vocabulary ttr_known.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"TTR_KNOWN_NODE"]) as $n) { $n->delete(); }
  if ($fc=FieldConfig::loadByName("node","article","field_ttr_kref")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_ttr_kref")) { $fs->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"ttr_known"]) as $t) { $t->delete(); }
  if ($v=Vocabulary::load("ttr_known")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ttr_known vocabulary, field_ttr_kref, and probe nodes removed"
