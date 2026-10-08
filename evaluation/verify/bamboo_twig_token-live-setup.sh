#!/usr/bin/env bash
# Introspection SETUP: ensure bamboo_twig_token is enabled (the token functions read live config).
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -q '^bamboo_twig_token$' || drush en bamboo_twig_token -y >/dev/null 2>&1
echo "setup: bamboo_twig_token enabled"
