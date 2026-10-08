#!/usr/bin/env bash
# Medium/introspection setup: put the site in the KNOWN state twig_vardumper manages —
# module enabled and caches rebuilt so its Twig extension (dump/vardumper functions) is
# live on the twig service. The agent must then inspect the running site to report the
# function names the extension registers.
set -uo pipefail
cd /var/www/html
drush pm:install twig_vardumper -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: twig_vardumper enabled; TwigExtension registered (dump + vardumper functions live)"
