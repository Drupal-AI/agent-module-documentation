#!/usr/bin/env bash
# Introspection SETUP: write a known subpathauto configuration (depth 4, redirects off) so an
# inspecting agent has to read the live config to answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("subpathauto.settings")
    ->set("depth", 4)
    ->set("redirect_support", FALSE)
    ->save();
' >/dev/null 2>&1
echo "setup: subpathauto.settings depth=4 redirect_support=FALSE"
