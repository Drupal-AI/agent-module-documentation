#!/usr/bin/env bash
# Introspection SETUP: set a distinctive datalayer value for the page_Name tag on the 'node'
# page context so an agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("advanced_datalayer_defaults")->load("node");
  $d->set("tags", ["page_Name" => "[node:title]-ADLMARK"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: advanced_datalayer_defaults.node tags.page_Name = [node:title]-ADLMARK"
