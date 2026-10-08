#!/usr/bin/env bash
# Execution RESET: delete any menu_position_rule with the id mp_task_article (and its derived
# menu link), so the matching verify FAILS until the agent builds the rule. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("menu_position_rule");
  if ($r = $storage->load("mp_task_article")) { $r->delete(); }
  \Drupal::service("plugin.manager.menu.link")->rebuild();
  print "exists=" . var_export((bool) $storage->load("mp_task_article"), TRUE) . "\n";
' 2>/dev/null
echo "reset: no mp_task_article rule"
