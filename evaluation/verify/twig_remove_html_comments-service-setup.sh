#!/usr/bin/env bash
# Introspection SETUP: ensure the module is enabled so its Twig extension service is
# discoverable on the live site, and confirm what an agent should be able to read back.
# No persistent state is written. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install twig_remove_html_comments -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: twig_remove_html_comments enabled; service twig_remove_html_comments.remove_html_comments discoverable"
