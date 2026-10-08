#!/usr/bin/env bash
# Execution CLEANUP: remove the unique_content_field_validation third-party settings from Article,
# restoring baseline. Idempotent. Exit 0.
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
echo "cleanup: node.article title uniqueness removed"
