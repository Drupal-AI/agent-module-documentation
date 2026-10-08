#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped subpathauto defaults (depth 0, redirects on).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("subpathauto.settings")
    ->set("depth", 0)
    ->set("redirect_support", TRUE)
    ->save();
' >/dev/null 2>&1
echo "cleanup: subpathauto.settings restored to depth=0 redirect_support=TRUE"
