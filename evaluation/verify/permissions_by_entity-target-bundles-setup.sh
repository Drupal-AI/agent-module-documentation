#!/usr/bin/env bash
# Introspection SETUP: create the vocabulary pbe_intro_vocab and point
# permissions_by_term.settings:target_bundles at it alone. permissions_by_entity only controls an
# entity when that list is non-empty AND intersects the taxonomy field's target bundles, so the
# agent must read the live setting. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  if (!Vocabulary::load("pbe_intro_vocab")) { Vocabulary::create(["vid" => "pbe_intro_vocab", "name" => "PBE Intro Vocab"])->save(); }
  \Drupal::configFactory()->getEditable("permissions_by_term.settings")
    ->set("target_bundles", ["pbe_intro_vocab"])->save();
  print json_encode(\Drupal::config("permissions_by_term.settings")->get("target_bundles")) . "\n";
' 2>/dev/null
echo "setup: target_bundles=[pbe_intro_vocab]"
