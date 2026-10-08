#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN block_group_content config entity so an inspecting
# agent can read back its human label from the live site. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("block_group_content");
  if ($e = $s->load("eval_footer_group")) { $e->delete(); }
  $s->create(["id" => "eval_footer_group", "label" => "Eval Footer Group"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block_group_content eval_footer_group created (label 'Eval Footer Group')"
