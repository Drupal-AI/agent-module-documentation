#!/usr/bin/env bash
# Introspection SETUP: create content type er_eval and configure Entity Redirect so that after
# ADDING a new node the user goes back to the add form, so an agent can read back the
# destination. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("er_eval") ?: NodeType::create(["type"=>"er_eval","name"=>"ER Eval"]);
  $t->setThirdPartySetting("entity_redirect", "redirect", [
    "add" => ["active" => TRUE, "destination" => "add_form", "url" => "", "external" => ""],
  ]);
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.er_eval entity_redirect add -> add_form"
