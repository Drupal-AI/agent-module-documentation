#!/usr/bin/env bash
# Introspection SETUP: mark the Article node type's title as unique via unique_content_field_validation
# third-party settings, so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("article")) {
    $t->setThirdPartySetting("unique_content_field_validation", "unique", TRUE);
    $t->setThirdPartySetting("unique_content_field_validation", "unique_text", "An Article titled \"%value\" already exists.");
    $t->save();
  }
' >/dev/null 2>&1
echo "setup: node.type.article unique title = TRUE"
