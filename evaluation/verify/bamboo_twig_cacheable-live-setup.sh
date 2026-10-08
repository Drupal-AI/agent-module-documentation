#!/usr/bin/env bash
# Introspection SETUP: ensure bamboo_twig_cacheable is enabled so its Twig function is registered.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -q '^bamboo_twig_cacheable$' || drush en bamboo_twig_cacheable -y >/dev/null 2>&1
echo "setup: bamboo_twig_cacheable enabled"
