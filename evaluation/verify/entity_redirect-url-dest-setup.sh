#!/usr/bin/env bash
# Introspection SETUP: create content type er_url and configure Entity Redirect so that after
# EDITING a node the user is sent to the local path /er-thank-you, so an agent can read back the
# configured URL. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("er_url") ?: NodeType::create(["type"=>"er_url","name"=>"ER Url"]);
  $t->setThirdPartySetting("entity_redirect", "redirect", [
    "edit" => ["active" => TRUE, "destination" => "url", "url" => "/er-thank-you", "external" => ""],
  ]);
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.er_url entity_redirect edit -> url /er-thank-you"
