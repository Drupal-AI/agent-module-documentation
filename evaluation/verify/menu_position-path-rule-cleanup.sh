#!/usr/bin/env bash
# Execution CLEANUP: delete the mp_task_docs rule and restore
# menu_position.settings:link_display to the shipped default 'parent'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("menu_position_rule");
  if ($r = $storage->load("mp_task_docs")) { $r->delete(); }
  \Drupal::configFactory()->getEditable("menu_position.settings")->set("link_display", "parent")->save();
  \Drupal::service("plugin.manager.menu.link")->rebuild();
  print "cleaned\n";
' 2>/dev/null
echo "cleanup: mp_task_docs removed, link_display=parent"
