#!/usr/bin/env bash
# Execution RESET: create the vocabulary pbt_lock_vocab and force permissions_by_term.settings
# back to its shipped defaults (permission_mode FALSE, require_all_terms_granted FALSE,
# target_bundles empty), so the matching verify FAILS until the agent reconfigures the module.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  if (!Vocabulary::load("pbt_lock_vocab")) { Vocabulary::create(["vid" => "pbt_lock_vocab", "name" => "PBT Lock Vocab"])->save(); }
  \Drupal::configFactory()->getEditable("permissions_by_term.settings")
    ->set("permission_mode", FALSE)
    ->set("require_all_terms_granted", FALSE)
    ->set("target_bundles", [])
    ->save();
  print json_encode(\Drupal::config("permissions_by_term.settings")->getRawData()) . "\n";
' 2>/dev/null
echo "reset: pbt_lock_vocab present, permissions_by_term.settings back to defaults"
