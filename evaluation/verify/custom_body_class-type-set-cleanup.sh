#!/usr/bin/env bash
# Execution CLEANUP: remove the Article classes setting. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("node_type")->load("article");
  $t->unsetThirdPartySetting("custom_body_class", "classes");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: article classes unset"
