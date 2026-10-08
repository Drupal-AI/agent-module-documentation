#!/usr/bin/env bash
# Execution CLEANUP: ensure node is reconciled (remove any leftover phantom). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (\Drupal::service("meaofd.fixer")->entityTypeHasChanges("node")) {
    \Drupal::service("meaofd.fixer")->fix("node");
  }
' >/dev/null 2>&1
echo "cleanup: node definitions reconciled"
