#!/usr/bin/env bash
# Execution RESET: baseline front_page.settings (override OFF, no role overrides) so verify
# FAILS until the agent enables override and sets an anonymous redirect. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("front_page.settings")
    ->set("enabled", FALSE)->set("roles", [])->clear("home_link_path")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: front_page override OFF, no role overrides"
