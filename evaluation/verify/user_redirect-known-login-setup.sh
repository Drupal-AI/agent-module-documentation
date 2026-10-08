#!/usr/bin/env bash
# Introspection SETUP: give the 'administrator' role a login redirect of /admin/content in
# user_redirect.settings so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("user_redirect.settings");
  $c->set("login.administrator.redirect_url", "/admin/content")->set("login.administrator.weight", 0)->save();
' >/dev/null 2>&1
echo "setup: user_redirect.settings login.administrator.redirect_url=/admin/content"
