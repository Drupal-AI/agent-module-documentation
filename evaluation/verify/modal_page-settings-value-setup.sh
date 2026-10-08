#!/usr/bin/env bash
# Introspection SETUP (modal_page M2): set the global modal_page.settings default cookie
# expiration to a known value (7777) and bootstrap version to 5x. The agent must inspect the
# live settings to report the default cookie expiration. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("modal_page.settings");
  $c->set("default_cookie_expiration", 7777)->set("bootstrap_version", "5x")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: modal_page.settings default_cookie_expiration=7777, bootstrap_version=5x"
