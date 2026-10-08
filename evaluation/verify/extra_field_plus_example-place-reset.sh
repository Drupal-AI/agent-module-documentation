#!/usr/bin/env bash
# Execution RESET: enable module and ensure Example Node Label is NOT placed on Article
# display, so verify FAILs until the agent places it.
set -uo pipefail
cd /var/www/html
drush en extra_field_plus_example -y >/dev/null 2>&1
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($fd) { $fd->removeComponent("extra_field_example_node_label")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: extra_field_example_node_label component absent"
