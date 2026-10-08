#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN date_recur_interpreter config entity so an inspecting
# agent can read it back. id eval_intro_interpreter, distinctive label, plugin rl, date_format
# long. Does not ship by default (separate from default_interpreter). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  // Recreate from scratch each run: the plugin collection requires "plugin" to be set at
  // create() time (setting it afterwards on an uninitialised entity errors).
  if ($old = \Drupal\date_recur\Entity\DateRecurInterpreter::load("eval_intro_interpreter")) { $old->delete(); }
  \Drupal\date_recur\Entity\DateRecurInterpreter::create([
    "id" => "eval_intro_interpreter",
    "label" => "Eval Intro Interpreter",
    "plugin" => "rl",
    "settings" => ["show_start_date" => TRUE, "show_until" => TRUE, "date_format" => "long", "show_infinite" => TRUE],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: date_recur_interpreter eval_intro_interpreter (plugin rl) created"
