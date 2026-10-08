#!/usr/bin/env bash
# MEDIUM introspection setup: create a known computed field on node.article so the agent
# can read back, from live config, which plugin supplies it and what core field type it is.
# The field uses the bundled reverse_entity_reference plugin (field type entity_reference).
# Restored by computed_field-known-plugin-cleanup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("computed_field");
  if ($e = $s->load("node.article.computed_eval_backlinks")) { $e->delete(); }
  $s->create([
    "field_name" => "computed_eval_backlinks",
    "entity_type" => "node",
    "bundle" => "article",
    "label" => "Eval Backlinks",
    "plugin_id" => "reverse_entity_reference",
    "plugin_config" => ["reference_field" => "node-uid"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.computed_eval_backlinks (reverse_entity_reference) created"
