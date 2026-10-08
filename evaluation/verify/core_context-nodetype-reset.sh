#!/usr/bin/env bash
# Execution RESET: ensure the Article content type (node_type config entity) has NO core_context
# context, so verify fails until the agent attaches one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("node_type")->load("article");
  $t->unsetThirdPartySetting("core_context", "contexts");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no core_context context on node.type.article"
