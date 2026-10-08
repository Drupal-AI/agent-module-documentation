#!/usr/bin/env bash
# Execution RESET: force twig_debugger.settings:enabled = 1 so verify FAILS until the agent
# turns Twig debugging OFF in the module config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("twig_debugger.settings")->set("enabled", 1)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: twig_debugger.settings:enabled = 1"
