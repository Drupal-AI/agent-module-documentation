#!/usr/bin/env bash
# Introspection CLEANUP: reset bypass_role to shipped default (empty array). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("pages_restriction.settings");
  $c->set("bypass_role", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pages_restriction bypass_role cleared"
