#!/usr/bin/env bash
# Introspection SETUP: write a known restriction mapping into pages_restriction.settings so an
# agent can read back the target that a restricted path redirects to. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("pages_restriction.settings");
  $c->set("pages_restriction", "pr-secret-page|pr-entry-target")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pages_restriction maps pr-secret-page|pr-entry-target"
