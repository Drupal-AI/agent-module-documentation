#!/usr/bin/env bash
# Execution RESET: ensure Article title is NOT marked unique (remove any third-party setting),
# so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("article")) {
    $t->unsetThirdPartySetting("unique_content_field_validation", "unique");
    $t->unsetThirdPartySetting("unique_content_field_validation", "unique_text");
    $t->save();
  }
' >/dev/null 2>&1
echo "reset: node.article title uniqueness OFF"
