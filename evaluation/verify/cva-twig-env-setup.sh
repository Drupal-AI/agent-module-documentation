#!/usr/bin/env bash
# Medium/introspection setup: put the site in the KNOWN state cva manages — module enabled
# and caches rebuilt so the decorated Twig environment + html_cva function are live. The
# agent must then inspect the running site to report the active twig env class / availability.
set -uo pipefail
cd /var/www/html
drush pm:install cva -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cva enabled; twig service decorated (CvaTwigEnvironment) and html_cva available"
