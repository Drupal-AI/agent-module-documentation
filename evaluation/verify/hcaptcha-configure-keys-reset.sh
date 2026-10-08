#!/usr/bin/env bash
# Execution RESET: clear hcaptcha.settings keys and theme to shipped defaults so verify FAILS
# until the agent configures them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("hcaptcha.settings");
  $c->set("site_key", "")->set("secret_key", "")->set("widget.theme", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: hcaptcha.settings site_key/secret_key empty, widget.theme=''"
