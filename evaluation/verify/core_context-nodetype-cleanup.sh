#!/usr/bin/env bash
# Execution CLEANUP: remove the core_context third-party setting from the Article node type.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("node_type")->load("article");
  $t->unsetThirdPartySetting("core_context", "contexts");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: core_context contexts removed from node.type.article"
