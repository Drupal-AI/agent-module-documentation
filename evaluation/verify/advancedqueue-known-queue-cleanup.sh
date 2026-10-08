#!/usr/bin/env bash
# Introspection CLEANUP: delete the AQ Reports queue created by the matching setup.
# The queue is locked, so delete via the storage handler which bypasses the UI access check.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\advancedqueue\Entity\Queue;
  if ($q = Queue::load("advancedqueue_aq_reports")) { $q->delete(); }
' >/dev/null 2>&1
echo "cleanup: advancedqueue_aq_reports queue removed"
