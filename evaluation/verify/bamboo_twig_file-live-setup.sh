#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -q '^bamboo_twig_file$' || drush en bamboo_twig_file -y >/dev/null 2>&1
echo "setup: bamboo_twig_file enabled"
