#!/usr/bin/env bash
# Introspection SETUP: install a KNOWN message_template config entity (id "eval_activity")
# with a specific text partial so an inspecting agent can read its pattern back.
# Idempotent: deletes any prior eval_activity template first. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("message_template");
  if ($t = $storage->load("eval_activity")) { $t->delete(); }
  $t = $storage->create([
    "template" => "eval_activity",
    "label" => "Eval Activity",
    "description" => "Known template installed for the introspection eval.",
    "text" => [
      ["value" => "[message:author:name] published [node:title]", "format" => "basic_html"],
    ],
    "settings" => ["token options" => ["token replace" => TRUE, "clear" => FALSE]],
  ]);
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: message_template eval_activity installed (partial: [message:author:name] published [node:title])"
