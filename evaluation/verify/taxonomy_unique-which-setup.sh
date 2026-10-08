#!/usr/bin/env bash
# Introspection SETUP: create two vocabularies tu_on (uniqueness enabled) and tu_off
# (uniqueness NOT enabled), so an agent must inspect config to tell which enforces it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $on = Vocabulary::load("tu_on") ?: Vocabulary::create(["vid" => "tu_on", "name" => "TU On"]);
  $on->setThirdPartySetting("taxonomy_unique", "enabled", TRUE);
  $on->setThirdPartySetting("taxonomy_unique", "message", "Term \"%term\" already exists in vocabulary \"%vocabulary\".");
  $on->save();
  $off = Vocabulary::load("tu_off") ?: Vocabulary::create(["vid" => "tu_off", "name" => "TU Off"]);
  $off->setThirdPartySetting("taxonomy_unique", "enabled", FALSE);
  $off->save();
' >/dev/null 2>&1
echo "setup: tu_on has uniqueness enabled, tu_off does not"
