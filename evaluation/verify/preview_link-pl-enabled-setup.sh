#!/usr/bin/env bash
# Introspection SETUP: enable the Article bundle for preview links on the live site.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("preview_link.settings")->set("enabled_entity_types",["node"=>["article"]])->save();' >/dev/null 2>&1
echo "setup: preview_link enabled_entity_types = node:[article]"
