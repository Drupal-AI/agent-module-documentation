#!/usr/bin/env bash
# MEDIUM introspection setup: create a computed field whose plugin_config holds a distinctive
# reference_field value, so the agent can read that configured value back from live config.
# Restored by computed_field-reference-config-cleanup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("computed_field");
  if ($e = $s->load("node.article.computed_eval_authored")) { $e->delete(); }
  $s->create([
    "field_name" => "computed_eval_authored",
    "entity_type" => "node",
    "bundle" => "article",
    "label" => "Eval Authored",
    "plugin_id" => "reverse_entity_reference",
    "plugin_config" => ["reference_field" => "node-field_eval_source"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.computed_eval_authored reference_field=node-field_eval_source created"
