#!/usr/bin/env bash
# Introspection CLEANUP: restore target_bundles to the shipped default (empty) and delete the
# pbe_intro_vocab vocabulary. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  \Drupal::configFactory()->getEditable("permissions_by_term.settings")->set("target_bundles", [])->save();
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach ($storage->loadByProperties(["vid" => "pbe_intro_vocab"]) as $t) { $t->delete(); }
  if ($v = Vocabulary::load("pbe_intro_vocab")) { $v->delete(); }
  print json_encode(\Drupal::config("permissions_by_term.settings")->get("target_bundles")) . "\n";
' 2>/dev/null
echo "cleanup: target_bundles reset, pbe_intro_vocab removed"
