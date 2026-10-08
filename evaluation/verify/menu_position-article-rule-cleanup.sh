#!/usr/bin/env bash
# Execution CLEANUP: delete the mp_task_article rule and rebuild derived menu links.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("menu_position_rule");
  if ($r = $storage->load("mp_task_article")) { $r->delete(); }
  \Drupal::service("plugin.manager.menu.link")->rebuild();
  print "cleaned\n";
' 2>/dev/null
echo "cleanup: mp_task_article removed"
