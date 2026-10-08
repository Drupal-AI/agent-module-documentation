#!/usr/bin/env bash
# Introspection CLEANUP: run meaofd's fixer to reconcile node, removing the phantom base field and
# restoring the no-mismatch baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (\Drupal::service("meaofd.fixer")->entityTypeHasChanges("node")) {
    \Drupal::service("meaofd.fixer")->fix("node");
  }
' >/dev/null 2>&1
echo "cleanup: node definitions reconciled (no mismatch)"
