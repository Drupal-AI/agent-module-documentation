#!/usr/bin/env bash
# Introspection SETUP: enable subpathauto's redirect integration with a distinctive depth so
# the agent must read the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("subpathauto.settings")
    ->set("depth", 2)
    ->set("redirect_support", TRUE)
    ->save();
' >/dev/null 2>&1
echo "setup: subpathauto.settings depth=2 redirect_support=TRUE"
