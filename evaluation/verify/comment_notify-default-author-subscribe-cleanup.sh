#!/usr/bin/env bash
# Introspection CLEANUP: restore enable_default.entity_author = FALSE (shipped default). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("comment_notify.settings");
  $ed = $c->get("enable_default") ?: ["watcher" => "none", "entity_author" => FALSE];
  $ed["entity_author"] = FALSE;
  $c->set("enable_default", $ed)->save();
' >/dev/null 2>&1
echo "cleanup: comment_notify enable_default.entity_author = FALSE"
