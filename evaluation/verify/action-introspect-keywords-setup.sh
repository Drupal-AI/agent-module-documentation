#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN advanced action — a node "Unpublish content
# containing keyword(s)" action (plugin node_unpublish_by_keyword_action) whose keyword
# list is a fixed, discoverable pair ("forbidden", "spamword") — so an inspecting agent
# (drush) can read the configured keywords back off the action config entity. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("action");
  if ($e = $s->load("eval_kw_action")) { $e->delete(); }
  $s->create([
    "id" => "eval_kw_action",
    "label" => "Eval Keyword Unpublish",
    "type" => "node",
    "plugin" => "node_unpublish_by_keyword_action",
    "configuration" => ["keywords" => ["forbidden", "spamword"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: action eval_kw_action created (keywords=forbidden,spamword)"
