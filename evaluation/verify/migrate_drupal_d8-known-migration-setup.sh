#!/usr/bin/env bash
# Introspection SETUP: ensure migrate_plus is enabled and create a known migration that uses the
# migrate_drupal_d8 d8_entity source (entity_type=node, bundle=article), so an inspecting agent can
# read back what it migrates. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en migrate_plus -y >/dev/null 2>&1
drush php:eval '
  use Drupal\migrate_plus\Entity\Migration;
  if (Migration::load("mdd8_known")) { Migration::load("mdd8_known")->delete(); }
  Migration::create([
    "id" => "mdd8_known",
    "label" => "MDD8 known source",
    "migration_group" => "default",
    "source" => ["plugin" => "d8_entity", "key" => "mdd8_source", "entity_type" => "node", "bundle" => "article"],
    "process" => ["title" => "title"],
    "destination" => ["plugin" => "entity:node", "default_bundle" => "article"],
  ])->save();
' >/dev/null 2>&1
echo "setup: migration mdd8_known (d8_entity, node/article) created"
