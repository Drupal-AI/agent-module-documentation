#!/usr/bin/env bash
# Introspection SETUP: set twig_debugger.settings:enabled = 0 so an inspecting agent can read
# back that Twig debugging is explicitly turned OFF in the module's config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("twig_debugger.settings")->set("enabled", 0)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: twig_debugger.settings:enabled = 0"
