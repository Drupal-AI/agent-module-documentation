#!/usr/bin/env bash
# Execution RESET: ensure the Article node type has NO custom_body_class classes, so verify
# FAILs until the agent sets them.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("node_type")->load("article");
  $t->unsetThirdPartySetting("custom_body_class", "classes");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: article custom_body_class.classes unset"
