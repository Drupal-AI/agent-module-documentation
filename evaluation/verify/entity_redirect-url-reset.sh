#!/usr/bin/env bash
# Execution RESET: ensure content type er_task2 exists with NO Entity Redirect configuration, so
# verify FAILS until the agent configures the edit->local-url redirect. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("er_task2") ?: NodeType::create(["type"=>"er_task2","name"=>"ER Task 2"]);
  $t->unsetThirdPartySetting("entity_redirect", "redirect");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node type er_task2 present with no entity_redirect settings"
