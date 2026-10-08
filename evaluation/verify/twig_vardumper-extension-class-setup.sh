#!/usr/bin/env bash
# Medium/introspection setup: ensure the KNOWN state — twig_vardumper enabled and caches
# rebuilt so its Twig extension service (Drupal\twig_vardumper\TwigExtension) is registered
# on the live twig service. The agent inspects the running site to report that class /
# the extension's getName().
set -uo pipefail
cd /var/www/html
drush pm:install twig_vardumper -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: twig_vardumper enabled; TwigExtension (name=twig_vardumper) registered on the twig service"
