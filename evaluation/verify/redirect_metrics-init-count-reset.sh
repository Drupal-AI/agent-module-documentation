#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure NO redirect with source 'rm-task-src' exists, so the verify
# (which requires the redirect to exist with an initialised access_count) FAILS on empty
# state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\redirect\Entity\Redirect;
  foreach (Redirect::loadMultiple() as $r) {
    if ($r->getSource()["path"] === "rm-task-src") { $r->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: redirect rm-task-src absent"
