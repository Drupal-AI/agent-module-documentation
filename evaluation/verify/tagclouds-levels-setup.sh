#!/usr/bin/env bash
# Introspection SETUP: set tagclouds levels=9 and sort_order=count,desc so an agent can read
# them back from the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tagclouds.settings")->set("levels",9)->set("sort_order","count,desc")->save();' >/dev/null 2>&1
echo "setup: tagclouds.settings levels=9 sort_order=count,desc"
