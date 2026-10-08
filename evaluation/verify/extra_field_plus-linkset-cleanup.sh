#!/usr/bin/env bash
# Execution CLEANUP: remove the formatted component. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($fd) { $fd->removeComponent("extra_field_example_node_label_formatted")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: extra_field_example_node_label_formatted component removed"
