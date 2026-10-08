#!/usr/bin/env bash
# Execution CLEANUP: delete every namespaced sapisorts_* sort field so the verify script fails
# (post-run teardown). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api_sorts\Entity\SearchApiSortsField;
  foreach (SearchApiSortsField::loadMultiple() as $e) {
    if (strpos($e->getDisplayId(), "sapisorts_display") === 0) { $e->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: sapisorts_* sort fields removed"
