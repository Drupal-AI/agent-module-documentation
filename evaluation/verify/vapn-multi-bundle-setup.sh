#!/usr/bin/env bash
# Introspection SETUP: enable VAPN on BOTH the 'article' and 'page' content types, so the agent
# must inspect the live vapn.settings config to list every content type using per-node view
# access. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("vapn.settings");
  $c->set("bundles", ["article" => TRUE, "page" => TRUE])->save();
  \Drupal::service("entity_field.manager")->clearCachedFieldDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vapn.settings bundles = {article:true, page:true}"
