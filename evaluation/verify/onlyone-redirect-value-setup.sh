#!/usr/bin/env bash
# Introspection SETUP: set onlyone.settings onlyone_redirect=false so an agent can read that a
# restricted type's second-add sends editors to the canonical page (not the edit form).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("onlyone.settings")->set("onlyone_redirect", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: onlyone.settings onlyone_redirect=false"
