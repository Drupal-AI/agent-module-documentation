#!/usr/bin/env bash
# Introspection SETUP: install a KNOWN pathauto_pattern for the Article content type
# (pattern string "articles/[node:title]") so an inspecting agent can read it back.
# Idempotent: deletes any prior eval_article pattern first. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $id = "eval_article";
  $storage = \Drupal::entityTypeManager()->getStorage("pathauto_pattern");
  if ($p = $storage->load($id)) { $p->delete(); }
  $pattern = $storage->create([
    "id" => $id,
    "label" => "Eval Article Pattern",
    "type" => "canonical_entities:node",
    "pattern" => "articles/[node:title]",
  ]);
  $pattern->addSelectionCondition([
    "id" => "entity_bundle:node",
    "bundles" => ["article" => "article"],
    "negate" => FALSE,
    "context_mapping" => ["node" => "node"],
    "uuid" => \Drupal::service("uuid")->generate(),
  ]);
  $pattern->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pathauto_pattern eval_article installed (node -> articles/[node:title], bundle article)"
