#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("domain_simple_sitemap.settings")->set("domain_simple_sitemap_replace_homepage",1)->save();' >/dev/null 2>&1
echo "setup: domain_simple_sitemap_replace_homepage=1"
