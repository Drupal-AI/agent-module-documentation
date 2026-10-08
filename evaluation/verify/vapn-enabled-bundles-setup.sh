#!/usr/bin/env bash
# Introspection SETUP: enable VAPN on the 'article' content type (vapn.settings bundles.article=true)
# and re-attach the vapn field, so the agent can inspect the live config to see which bundles use
# per-node view access. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("vapn.settings");
  $b = $c->get("bundles") ?: [];
  $b["article"] = TRUE;
  $c->set("bundles", $b)->save();
  \Drupal::service("entity_field.manager")->clearCachedFieldDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vapn.settings bundles.article=true"
