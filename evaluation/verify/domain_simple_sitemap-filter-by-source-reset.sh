#!/usr/bin/env bash
# Execution RESET (also CLEANUP): domain_simple_sitemap_filter=0 so verify FAILS until set to 1. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("domain_simple_sitemap.settings")->set("domain_simple_sitemap_filter",0)->save();' >/dev/null 2>&1
echo "reset: domain_simple_sitemap_filter=0"
