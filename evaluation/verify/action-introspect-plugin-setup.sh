#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN advanced action that reassigns a node's author
# (plugin node_assign_owner_action) targeting uid 1 — so an inspecting agent can read back
# which Action plugin the config entity uses. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("action");
  if ($e = $s->load("eval_owner_action")) { $e->delete(); }
  $s->create([
    "id" => "eval_owner_action",
    "label" => "Eval Reassign Author",
    "type" => "node",
    "plugin" => "node_assign_owner_action",
    "configuration" => ["owner_uid" => "1"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: action eval_owner_action created (plugin=node_assign_owner_action, owner_uid=1)"
