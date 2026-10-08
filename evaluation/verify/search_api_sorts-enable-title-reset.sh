#!/usr/bin/env bash
# Execution RESET: delete every namespaced sapisorts_* sort field so the verify script fails
# until the agent enables a 'title' sort for display 'sapisorts_display'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api_sorts\Entity\SearchApiSortsField;
  foreach (SearchApiSortsField::loadMultiple() as $e) {
    if (strpos($e->getDisplayId(), "sapisorts_display") === 0) { $e->delete(); }
  }
' >/dev/null 2>&1
echo "reset: no sapisorts_* sort fields"
