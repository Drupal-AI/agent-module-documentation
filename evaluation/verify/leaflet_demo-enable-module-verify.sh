#!/usr/bin/env bash
# Execution VERIFY for "enable the leaflet_demo submodule". PASS when leaflet_demo is
# installed AND its route resolves. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
enabled=$(drush pm:list --status=enabled --field=name 2>/dev/null | grep -x 'leaflet_demo' || true)
route_ok=$(drush php:eval "print (int) (bool) \Drupal::service('router.route_provider')->getRouteByName('leaflet_demo.demo_page');" 2>/dev/null || echo 0)
if [ -n "$enabled" ] && [ "$route_ok" = "1" ]; then
  echo "PASS enabled=yes route=leaflet_demo.demo_page"
  exit 0
else
  echo "FAIL enabled=${enabled:-no} route_ok=$route_ok"
  exit 1
fi
