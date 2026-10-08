#!/usr/bin/env bash
# Introspection SETUP: set comment_notify enable_default.entity_author = TRUE. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("comment_notify.settings");
  $ed = $c->get("enable_default") ?: ["watcher" => "none", "entity_author" => FALSE];
  $ed["entity_author"] = TRUE;
  $c->set("enable_default", $ed)->save();
' >/dev/null 2>&1
echo "setup: comment_notify enable_default.entity_author = TRUE"
