#!/usr/bin/env bash
# Introspection SETUP: set conflict.settings resolution_type.node.article to "dialog" so an
# inspecting agent can read the configured strategy for Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("conflict.settings")->set("resolution_type.node.article","dialog")->save();' >/dev/null 2>&1
echo "setup: conflict.settings resolution_type.node.article=dialog"
