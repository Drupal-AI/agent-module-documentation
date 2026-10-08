#!/usr/bin/env bash
# Introspection SETUP: set a distinctive items_per_page on visitors.config so the agent can read
# it back. Baseline is 10. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("visitors.config")->set("items_per_page", 47)->save();' >/dev/null 2>&1
echo "setup: visitors.config items_per_page=47"
