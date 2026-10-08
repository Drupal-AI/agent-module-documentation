#!/usr/bin/env bash
# Introspection SETUP: create vocabulary nodeorder_tags and mark it orderable in nodeorder.settings,
# so an agent can read back which vocabulary is orderable. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  if (!Vocabulary::load("nodeorder_tags")) { Vocabulary::create(["vid"=>"nodeorder_tags","name"=>"NodeOrder Tags"])->save(); }
  \Drupal::service("nodeorder.config_manager")->updateOrderableValue("nodeorder_tags", TRUE);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vocabulary nodeorder_tags is orderable in nodeorder.settings"
