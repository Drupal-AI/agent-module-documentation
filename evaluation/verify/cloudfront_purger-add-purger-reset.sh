#!/usr/bin/env bash
# Execution RESET: remove all purgers so verify FAILS until the agent registers the cloudfront purger.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("purge.plugins")->set("purgers", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: purge.plugins purgers cleared"
