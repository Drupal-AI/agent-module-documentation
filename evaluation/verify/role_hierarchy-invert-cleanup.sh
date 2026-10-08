#!/usr/bin/env bash
# Introspection CLEANUP: delete role_hierarchy.settings (baseline = config absent). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("role_hierarchy.settings");
  if (!$c->isNew()) { $c->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role_hierarchy.settings deleted"
