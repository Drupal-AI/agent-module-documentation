#!/usr/bin/env bash
# Execution RESET: disable VAPN everywhere (vapn.settings bundles = {}), so verify FAILS until
# the agent enables it on the article content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("vapn.settings");
  $c->set("bundles", [])->save();
  \Drupal::service("entity_field.manager")->clearCachedFieldDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vapn.settings bundles = {}"
