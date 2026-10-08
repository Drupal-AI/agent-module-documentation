#!/usr/bin/env bash
# Introspection SETUP: ensure gin_type_tray is enabled and the router cache is rebuilt, so the
# live node.add_page route reflects gin_type_tray's route subscriber. The answer (the overriding
# controller) is then discoverable by inspecting the running site's routing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en gin_type_tray -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: gin_type_tray enabled; node.add_page route rebuilt"
