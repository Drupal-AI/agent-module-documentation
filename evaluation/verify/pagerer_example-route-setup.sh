#!/usr/bin/env bash
# Introspection SETUP (no mutation): baseline for locating the Pagerer example page route on the
# running site. pagerer_example is enabled; its route pagerer_example.page serves /pagerer/example.
set -uo pipefail
cd /var/www/html
p=$(drush php:eval 'try { print \Drupal::service("router.route_provider")->getRouteByName("pagerer_example.page")->getPath(); } catch (\Exception $e) { print "no-route"; }' 2>/dev/null)
echo "setup: pagerer_example.page path=$p"
