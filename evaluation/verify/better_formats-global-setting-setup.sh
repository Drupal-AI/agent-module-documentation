#!/usr/bin/env bash
# Introspection SETUP: turn ON the global "Use field default" (per_field_core) so an agent can
# read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("better_formats.settings")->set("per_field_core", TRUE)->save();' >/dev/null 2>&1
echo "setup: better_formats.settings per_field_core=TRUE"
