#!/usr/bin/env bash
# CLEANUP: restore the shipped default Home label ('Home'). Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set custom_breadcrumbs.settings home_link 'Home' -y >/dev/null 2>&1
echo "cleanup: home_link restored to Home"
