#!/usr/bin/env bash
# Restore baseline: twig_vardumper is part of the cumulative install and stays enabled.
# Idempotently re-ensure the enabled+rebuilt state so the site is left as the suite expects.
set -uo pipefail
cd /var/www/html
drush pm:install twig_vardumper -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: twig_vardumper left enabled (baseline)"
