#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN advanced comment action (plugin
# comment_unpublish_by_keyword_action) so an inspecting agent can read back which entity
# type (`type`) the action operates on — here it is `comment`. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("action");
  if ($e = $s->load("eval_comment_action")) { $e->delete(); }
  $s->create([
    "id" => "eval_comment_action",
    "label" => "Eval Comment Keyword Unpublish",
    "type" => "comment",
    "plugin" => "comment_unpublish_by_keyword_action",
    "configuration" => ["keywords" => ["blocked"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: action eval_comment_action created (type=comment)"
