#!/usr/bin/env bash
# Introspection SETUP: create a schema-less simple config object config_inspector_test.settings
# with a known marker value, so an inspecting agent can (a) see it has "No schema" and (b) read
# the marker. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_inspector_test.settings")->set("marker","CI_MED_SENTINEL")->save();' >/dev/null 2>&1
echo "setup: config_inspector_test.settings created (no schema, marker=CI_MED_SENTINEL)"
