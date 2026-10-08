#!/usr/bin/env bash
# Execution RESET: delete any mp_task_docs rule and force menu_position.settings:link_display
# back to the default 'parent', so the matching verify FAILS on both counts until the agent
# builds the path rule and switches the display mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("menu_position_rule");
  if ($r = $storage->load("mp_task_docs")) { $r->delete(); }
  \Drupal::configFactory()->getEditable("menu_position.settings")->set("link_display", "parent")->save();
  \Drupal::service("plugin.manager.menu.link")->rebuild();
  print "exists=" . var_export((bool) $storage->load("mp_task_docs"), TRUE)
    . " link_display=" . \Drupal::config("menu_position.settings")->get("link_display") . "\n";
' 2>/dev/null
echo "reset: no mp_task_docs rule, link_display=parent"
