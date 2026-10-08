#!/usr/bin/env bash
# Introspection CLEANUP: delete twig_debugger.settings to restore the never-configured
# baseline (the config does not exist on a fresh install). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("twig_debugger.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: twig_debugger.settings deleted (baseline)"
