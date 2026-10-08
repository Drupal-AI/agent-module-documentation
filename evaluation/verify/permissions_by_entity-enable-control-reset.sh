#!/usr/bin/env bash
# Execution RESET: uninstall the permissions_by_entity submodule and clear
# permissions_by_term.settings:target_bundles, while making sure the vocabulary pbe_task_vocab
# exists. In this state the submodule cannot restrict anything, so the matching verify FAILS.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu permissions_by_entity -y >/dev/null 2>&1
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  if (!Vocabulary::load("pbe_task_vocab")) { Vocabulary::create(["vid" => "pbe_task_vocab", "name" => "PBE Task Vocab"])->save(); }
  \Drupal::configFactory()->getEditable("permissions_by_term.settings")->set("target_bundles", [])->save();
  print "enabled=" . var_export(\Drupal::moduleHandler()->moduleExists("permissions_by_entity"), TRUE)
    . " target_bundles=" . json_encode(\Drupal::config("permissions_by_term.settings")->get("target_bundles")) . "\n";
' 2>/dev/null
echo "reset: permissions_by_entity uninstalled, target_bundles empty, pbe_task_vocab present"
