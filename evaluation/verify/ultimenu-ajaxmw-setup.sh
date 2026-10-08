#!/usr/bin/env bash
# Introspection SETUP: set ultimenu.settings ajaxmw (AJAX mobile max-width) to a known value 481px,
# so an agent can read back the configured AJAX mobile max-width. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("ultimenu.settings");
  $c->set("ajaxmw", "481px")->save();
' >/dev/null 2>&1
echo "setup: ultimenu.settings ajaxmw=481px"
