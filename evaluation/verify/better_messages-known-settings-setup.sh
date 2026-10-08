#!/usr/bin/env bash
# Introspection SETUP: write known Better Messages settings (position top-right, autoclose 7s,
# width 642px) so an inspecting agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("better_messages.settings");
  $c->set("position", "tr")->set("autoclose", 7)->set("width", "642px")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: better_messages.settings position=tr autoclose=7 width=642px"
