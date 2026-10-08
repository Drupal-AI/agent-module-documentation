#!/usr/bin/env bash
# Introspection CLEANUP: delete the mp_intro_a / mp_intro_b fixture rules and rebuild the
# derived menu links. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("menu_position_rule");
  foreach (["mp_intro_a", "mp_intro_b"] as $id) {
    if ($r = $storage->load($id)) { $r->delete(); }
  }
  \Drupal::service("plugin.manager.menu.link")->rebuild();
  print "cleaned\n";
' 2>/dev/null
echo "cleanup: mp_intro_* rules removed"
