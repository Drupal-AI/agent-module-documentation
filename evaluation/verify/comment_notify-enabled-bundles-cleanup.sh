#!/usr/bin/env bash
# Introspection CLEANUP: restore bundle_types to shipped default [node--article--comment]. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("comment_notify.settings")->set("bundle_types", ["node--article--comment"])->save();
' >/dev/null 2>&1
echo "cleanup: bundle_types restored to [node--article--comment]"
