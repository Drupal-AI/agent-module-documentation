#!/usr/bin/env bash
# Introspection SETUP: set the module's needs-rebuild state flag so an agent can report the
# live rebuild status. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->set("views_url_alias.needs_rebuild", TRUE);' >/dev/null 2>&1
echo "setup: state views_url_alias.needs_rebuild = TRUE"
