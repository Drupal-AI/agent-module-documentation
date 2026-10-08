#!/usr/bin/env bash
# Introspection SETUP: place a KNOWN instance of the Events Feed block (plugin events_block)
# with id "eval_drupical_block" into the "sidebar" region of the default theme, so an
# inspecting agent can read back which region it sits in. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("block");
  if ($b = $s->load("eval_drupical_block")) { $b->delete(); }
  $theme = \Drupal::config("system.theme")->get("default");
  $s->create([
    "id" => "eval_drupical_block",
    "plugin" => "events_block",
    "theme" => $theme,
    "region" => "sidebar",
    "weight" => 0,
    "settings" => ["id" => "events_block", "label" => "Eval Events Feed", "label_display" => "visible"],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block eval_drupical_block (events_block) placed in region=sidebar"
