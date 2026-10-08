#!/usr/bin/env bash
# Introspection SETUP: create content type nep_med so the agent can inspect its node add
# form and confirm the node_edit_protection library is attached. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("nep_med")) {
    NodeType::create(["type" => "nep_med", "name" => "NEP Med"])->save();
  }
' >/dev/null 2>&1
echo "setup: content type nep_med present"
