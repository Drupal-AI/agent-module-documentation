#!/usr/bin/env bash
# Introspection SETUP: create the vocabulary pbt_cfg_vocab and point permissions_by_term at it
# only, while turning permission_mode ON and require_all_terms_granted ON (all three differ from
# the shipped defaults), so the agent must read the live settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  if (!Vocabulary::load("pbt_cfg_vocab")) { Vocabulary::create(["vid" => "pbt_cfg_vocab", "name" => "PBT Cfg Vocab"])->save(); }
  \Drupal::configFactory()->getEditable("permissions_by_term.settings")
    ->set("permission_mode", TRUE)
    ->set("require_all_terms_granted", TRUE)
    ->set("target_bundles", ["pbt_cfg_vocab"])
    ->save();
  print json_encode(\Drupal::config("permissions_by_term.settings")->getRawData()) . "\n";
' 2>/dev/null
echo "setup: permission_mode=TRUE, require_all_terms_granted=TRUE, target_bundles=[pbt_cfg_vocab]"
