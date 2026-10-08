#!/usr/bin/env bash
# Execution CLEANUP: clear target_bundles, delete the pbe_task_vocab vocabulary and leave the
# permissions_by_entity submodule installed (its documented baseline on this site).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en permissions_by_entity -y >/dev/null 2>&1
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  \Drupal::configFactory()->getEditable("permissions_by_term.settings")->set("target_bundles", [])->save();
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach ($storage->loadByProperties(["vid" => "pbe_task_vocab"]) as $t) { $t->delete(); }
  if ($v = Vocabulary::load("pbe_task_vocab")) { $v->delete(); }
  print "enabled=" . var_export(\Drupal::moduleHandler()->moduleExists("permissions_by_entity"), TRUE) . "\n";
' 2>/dev/null
echo "cleanup: pbe_task_vocab removed, target_bundles reset, submodule re-enabled"
