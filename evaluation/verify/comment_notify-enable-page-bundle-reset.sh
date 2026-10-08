#!/usr/bin/env bash
# Execution RESET (also CLEANUP): restore comment_notify bundle_types to the shipped default
# [node--article--comment] so verify FAILS until node--page--comment is added. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("comment_notify.settings")->set("bundle_types", ["node--article--comment"])->save();
' >/dev/null 2>&1
echo "reset: bundle_types = [node--article--comment]"
