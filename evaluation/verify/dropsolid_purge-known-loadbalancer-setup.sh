#!/usr/bin/env bash
# Introspection SETUP: seed dropsolid_purge.config with a varnish loadbalancer at 203.0.113.9:6081. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("dropsolid_purge.config")
    ->set("site_name", "DocSite")
    ->set("loadbalancers", ["varnish" => ["ip" => "203.0.113.9", "protocol" => "http", "port" => "6081"]])
    ->save();
' >/dev/null 2>&1
echo "setup: dropsolid_purge.config loadbalancers.varnish.ip=203.0.113.9 port=6081"
