#!/usr/bin/env bash
# Restore baseline: twig_vardumper stays enabled (cumulative install). Idempotently
# re-ensure the enabled+rebuilt state.
set -uo pipefail
cd /var/www/html
drush pm:install twig_vardumper -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: twig_vardumper left enabled (baseline)"
