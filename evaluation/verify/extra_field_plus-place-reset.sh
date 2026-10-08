#!/usr/bin/env bash
# Execution RESET: enable submodule, ensure the Example Node Label extra field is NOT placed
# on Article default display, so verify FAILs until the agent places it with wrapper h3.
set -uo pipefail
cd /var/www/html
drush en extra_field_plus_example -y >/dev/null 2>&1
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($fd) { $fd->removeComponent("extra_field_example_node_label")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: extra_field_example_node_label component absent"
