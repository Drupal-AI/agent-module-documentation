#!/usr/bin/env bash
# Execution CLEANUP: delete twig_debugger.settings to restore baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("twig_debugger.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: twig_debugger.settings deleted (baseline)"
