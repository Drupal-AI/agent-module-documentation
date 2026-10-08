#!/usr/bin/env bash
# Introspection SETUP: create vocabulary tu_known with taxonomy_unique enabled and a known
# custom duplicate message, so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("tu_known") ?: Vocabulary::create(["vid" => "tu_known", "name" => "TU Known"]);
  $v->setThirdPartySetting("taxonomy_unique", "enabled", TRUE);
  $v->setThirdPartySetting("taxonomy_unique", "message", "TU duplicate blocked: %term in %vocabulary");
  $v->save();
' >/dev/null 2>&1
echo "setup: vocabulary tu_known has taxonomy_unique enabled, message set"
