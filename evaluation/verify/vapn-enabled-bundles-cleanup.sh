#!/usr/bin/env bash
# Introspection CLEANUP: restore vapn.settings to the shipped baseline (no bundles enabled).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("vapn.settings");
  $c->set("bundles", [])->save();
  \Drupal::service("entity_field.manager")->clearCachedFieldDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vapn.settings bundles reset to {}"
